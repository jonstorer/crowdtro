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

  @Given /^the following Concern exists:$/, (table, next) ->
    for concern in table.hashes()
      concern.complete = concern.complete == 'true'
      Concern.create concern, next
