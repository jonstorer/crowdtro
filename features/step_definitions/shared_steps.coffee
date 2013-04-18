should   = require 'should'
mongoose = require 'mongoose'
Concern  = mongoose.models.Concern
User     = mongoose.models.User

module.exports = ->
  @World = require('../support/world').World

  @Given /^I open a new browser$/, (next) ->
    @resetBrowser next

  @Then /^I (?:am logged|log) in as:$/, (table, next) ->
    login = (user) =>
      @visit '/login', =>
        @$.post "/login_for_test/#{user.id}", (user, status, xhr) ->
          throw('failed') if status != 'success'
          next()

    User.findOne table.hashes()[0], (err, user) =>
      console.log err if err
      if user
        login(user)
      else
        User.create table.hashes()[0], (err, user) =>
          console.log err if err
          login(user)

  @Then /^I wait (\d+) seconds?$/, (seconds, next) ->
    setTimeout next, parseInt(seconds) * 1000

  @Given /^I (?:am on|go to) (.+)$/, (selector, next) ->
    @selectorFor selector, (path) =>
      @visit path, next

  @Given /^I should be on (.+)$/, (path, next) ->
    @selectorFor path, (path) =>
      path.should.eql @browser.window.location.pathname
      next()

  @Given /^I reload the page$/, (next) ->
    @browser.reload next

  @Then /^show me the contents of (.+)$/, (namedElement, next) ->
    @selectorFor namedElement, (selector) =>
      console.log @browser.html selector
      next()

  @Then /^I should (not )?see (.+)$/, (negator, namedElement, next) ->
    @selectorFor namedElement, (selector) =>
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
    @selectorFor namedElement, (selector) =>
      element = @browser.query selector
      should.exist(element, "could not find '#{selector}'")

      content  = @browser.text selector
      if negator
        content.should.not.include text, "expected '#{namedElement} (#{selector})' to not include '#{text}'"
      else
        content.should.include text, "expected '#{namedElement} (#{selector})' to include '#{text}'"
      next()

  @When /^I enter "([^"]+)" in (.+)$/, (text, namedElement, next) ->
    @selectorFor namedElement, (selector) =>
      element = @browser.query selector
      @browser.fill(element, text, next)

  @When /^I press "(.*)"$/, (button, next) ->
    buttonSelector = "input[value='#{button}']"
    @browser.pressButton buttonSelector, next

  @When /^I press "(.*)" within (.+)$/, (button, namedElement, next) ->
    @selectorFor namedElement, (selector) =>
      buttonSelector = "#{selector} input[value='#{button}']"
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
