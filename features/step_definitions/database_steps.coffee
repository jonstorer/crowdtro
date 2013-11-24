should   = require 'should'
mongoose = require '../../models/db'
Concern  = mongoose.models.Concern

module.exports = ->
  @World = require('../support/world').World

  @Before (next) ->
    mongoose.connection.db.dropDatabase next

  @Given /^a "([^"]+)" Concern exists$/, (content, next) ->
    attrs = { content: content }
    Concern.create attrs, next

  @Given /^the following Concern(?:s)? exist(?:s)?:$/, (table, next) ->
    concerns = for concern in table.hashes()
      for field, value of concern
        try
          concern[field] = JSON.parse(value)
        catch err
          # nothing
        concern

    do create = ->
      if concern = concerns.shift()
        Concern.create concern, create
      else
        next()
