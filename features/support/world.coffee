Browser   = require 'zombie'
should    = require 'should'
selectors = require './selectors'

process.env.PORT     ||= 4404
process.env.NODE_ENV ||= 'test'

server = require '../../server'

# Zombie options
Browser.site = "http://localhost:#{process.env.PORT}/"
Browser.debug = true if process.env.DEBUG == 'true'

class World
  constructor: (callback) ->
    @browser = new Browser()

    callback(@)

  selectorFor: (locator, callback = (s) -> s) ->
    for regexp, path of selectors
      if match = locator.match(new RegExp(regexp))
        return path.apply @, match.slice(1).concat [ callback ]

  resetBrowser : (next) ->
    console.log '#TODO fix me'
    path = @browser.window.location.pathname
    @browser = new Browser()
    @visit path, next

  visit: (url, next) ->
    @browser.visit url, (err, browser, status) =>
      console.log err if err
      @$ = browser.window.$
      next err, browser, status

  keyIdFor: (type) ->
    switch type
      when 'enter' then 13
      else 0

module.exports.World = World
