should      = require 'should'
selectors   = require './selectors'
Rosie       = require 'rosie'

require '../../spec/factories'

process.env.PORT     ||= 4404
process.env.NODE_ENV ||= 'test'

server = require '../../server'

Browser = require('zombie')
Browser.site = "http://localhost:#{process.env.PORT}"
Browser.debug = true

class World
  constructor: (callback) ->
    @browser = new Browser
    callback(@)

  selectorFor: (locator, callback = (s) -> s) ->
    for regexp, path of selectors
      if match = locator.match(new RegExp(regexp))
        return path.apply @, match.slice(1).concat [ callback ]

  resetBrowser : (next) ->
    console.log '#TODO fix me'
    path = @browser.window.location.pathname
    @browser = new Browser
    @visit path, next

  visit: (url, next) ->
    @browser.visit "#{Browser.site}#{url}", (err) =>
      if 0 in @browser.errors
        console.log @browser.errors
      throw err if err
      @$ = @browser.window.$
      next()

  keyIdFor: (type) ->
    switch type
      when 'enter' then 13
      else 0

  Factory: (factoryName, attrs = {}) ->
    for key, value in attrs
      try
        attrs[key] = JSON.parse(value)
      catch error
        # nothing
    Rosie.Factory.attributes(factoryName, attrs)

module.exports.World = World
