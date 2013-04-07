should   = require 'should'
mongoose = require '../../models/db'
Concern  = mongoose.models.Concern

module.exports = ->
  @World = require('../support/world').World

  @Before (next) ->
    mongoose.connection.db.dropDatabase next

  @Given /^a "([^"]+)" Concern exists$/, (content, next) ->
    attrs = { content: content }
    mongoose.models.Concern.create attrs, next
