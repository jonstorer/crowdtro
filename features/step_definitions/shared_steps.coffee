should   = require 'should'
mongoose = require 'mongoose'
Concern  = mongoose.models.Concern

module.exports = ->
  @World = require('../support/world').World

  @Then /^I wait (\d+) seconds?$/, (seconds, next) ->
    setTimeout next, parseInt(seconds) * 1000

  @Given /^I am on (.+)$/, (path, next) ->
    @visit @selectorFor(path), next

  @Given /^I reload the page$/, (next) ->
    @browser.reload next

  @Then /^show me the contents of (.+)$/, (namedElement, next) ->
    selector = @selectorFor namedElement
    console.log @browser.html selector
    next()

  @Then /^I should (not )?see (.+)$/, (negator, namedElement, next) ->
    selector = @selectorFor namedElement
    element  = @browser.query selector
    if negator
      should.not.exist(element, "should not have find '#{selector}', but did")
    else
      should.exist(element, "could not find '#{selector}'")

    next()

  @Then /^(.+) should be (visible|hidden)$/, (namedElement, visibility, next) ->
    @selectorFor namedElement, (selector) =>
      element = @browser.query selector
      should.exist(element, "could not find '#{selector}'")
      @$(selector).is(":#{ visibility }")
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

  @When /^I click (.*)$/, (namedElement, next) ->
    @selectorFor namedElement, (selector) =>
      @browser.clickLink selector, next

  @When /^I click "([^"]+)"$/, (link, next) ->
    @browser.clickLink link, next

  @When /^I check off "([^"]+)"$/, (value, next) ->
    Concern.findOne { content: value }, (err, concern) =>
      throw err if err
      @browser.check("#concern-#{ concern.id } input", next)

  @When /^I uncheck "([^"]+)"$/, (value, next) ->
    Concern.findOne { content: value }, (err, concern) =>
      throw err if err
      @browser.uncheck("#concern-#{ concern.id } input", next)
