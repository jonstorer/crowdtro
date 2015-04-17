should   = require 'should'
mongoose = require('mongoose')
Concern  = require('../../models').Concern

module.exports = ->
  @World = require('../support/world').World

  @Before (next) ->
    mongoose.connection.db.dropDatabase next

  @Given /^a "([^"]+)" Concern exists$/, (content, next) ->
    attrs = { content: content }
    Concern.create attrs, next

  @Given /^the following Concern(?:s)? exist(?:s)?:$/, (table, next) ->
    concerns = for concern in table.hashes()
      concern.complete = concern.complete == 'true'
      concern

    do create = ->
      if concern = concerns.shift()
        Concern.create concern, create
      else
        next()
