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

  visit: (url, next) ->
    @browser.visit url, (err, browser, status) =>
      console.log err if err
      @$ = browser.window.$
      next err, browser, status

module.exports.World = World
