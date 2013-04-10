should   = require 'should'
mongoose = require 'mongoose'
Concern  = mongoose.models.Concern

module.exports = ->
  @World = require('../support/world').World

  @Then /^I wait (\d+) seconds?$/, (seconds, next) ->
    setTimeout next, parseInt(seconds) * 1000

  @Given /^I am on (.+)$/, (path, next) ->
    @visit @selectorFor(path), next

  @Then /^show me the contents of (.+)$/, (namedElement, next) ->
    selector = @selectorFor namedElement
    console.log @browser.html selector
    next()

  @Then /^I should see (.+)$/, (namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    should.exist(element, "could not find '#{selector}'")
    next()

  @Then /^(.+) should be visible$/, (namedElement, next) ->
    @selectorFor namedElement, (selector) =>
      element = @browser.query selector
      should.exist(element, "could not find '#{selector}'")
      next()

  @Then /^I should (not )?see "([^"]+)" within (.+)$/, (negator, text, namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    should.exist(element, "could not find '#{selector}'")

    content  = @browser.text selector
    if negator
      content.should.not.include text, "expected '#{namedElement} (#{selector})' to not include '#{text}'"
    else
      content.should.include text, "expected '#{namedElement} (#{selector})' to include '#{text}'"
    next()

  @When /^I enter "([^"]+)" in (.+)$/, (text, namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    @browser.fill(element, text, next)

  @When /^I press "(.*)"$/, (button, next) ->
    buttonSelector = "input[value='#{button}']"
    @browser.pressButton buttonSelector, next

  @When /^I press (.*)$/, (namedElement, next) ->
    #throw 'here is where the error is, it all has to do with call backs'
    @selectorFor namedElement, (selector) =>
      @browser.pressButton selector, next

  @When /^I check off "([^"]+)"$/, (value, next) ->
    Concern.findOne { content: value }, (err, concern) =>
      throw err if err
      @browser.check("#concern-#{ concern.id } input", next)

  @When /^I uncheck "([^"]+)"$/, (value, next) ->
    Concern.findOne { content: value }, (err, concern) =>
      throw err if err
      @browser.uncheck("#concern-#{ concern.id } input", next)
