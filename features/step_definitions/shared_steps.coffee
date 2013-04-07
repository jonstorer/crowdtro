should   = require 'should'
mongoose = require '../../models/db'

module.exports = ->
  @World = require('../support/world').World

  @Before (next) ->
    mongoose.connection.db.dropDatabase next

  @Given /^I am on (.+)$/, (path, next) ->
    @visit @selectorFor(path), next

  @Then /^I should see (.+)$/, (namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    should.exist(element, "could not find 'form#new-concern")
    next()

  @Then /^I should see "([^"]+)" within (.+)$/, (text, namedElement, next) ->
    selector = @selectorFor namedElement
    content  = @browser.text selector
    content.should.include text, "expected '#{namedElement}' to include '#{text}'"
    next()

  @When /^I enter "([^"]+)" in (.+)$/, (text, namedElement, next) ->
    selector = @selectorFor namedElement
    element = @browser.query selector
    @browser.fill(element, text)
    next()

  @When /^I press "(.*)"$/, (button, next) ->
    buttonSelector = "input[value='#{button}']"
    @browser.pressButton buttonSelector, next

