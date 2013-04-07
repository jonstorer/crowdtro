should   = require 'should'
mongoose = require 'mongoose'
Concern  = mongoose.models.Concern

module.exports = ->
  @World = require('../support/world').World

  @Given /^I am on (.+)$/, (path, next) ->
    @visit @selectorFor(path), next

  @Then /^I should see (.+)$/, (namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    should.exist(element, "could not find 'form#new-concern")
    next()

  @Then /^I should (not )?see "([^"]+)" within (.+)$/, (negator, text, namedElement, next) ->
    selector = @selectorFor namedElement
    content  = @browser.text selector
    if negator
      content.should.not.include text, "expected '#{namedElement}' to not include '#{text}'"
    else
      content.should.include text, "expected '#{namedElement}' to include '#{text}'"
    next()

  @When /^I enter "([^"]+)" in (.+)$/, (text, namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    @browser.fill(element, text, next)

  @When /^I press "(.*)"$/, (button, next) ->
    buttonSelector = "input[value='#{button}']"
    @browser.pressButton buttonSelector, next

  @When /^I check off "([^"]+)"$/, (value, next) ->
    Concern.findOne { content: value }, (err, concern) =>
      throw err if err
      element = @browser.query("#concern-#{ concern.id } input")
      element.setAttribute('checked', 'checked')
      @browser.fire 'change', element, next
