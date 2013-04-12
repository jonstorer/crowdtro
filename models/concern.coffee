mongoose   = require './db'
timestamps = require 'mongoose-times'

concernSchema = new mongoose.Schema
  content: String
  complete:
    type: Boolean
    default: false

# pluggins
concernSchema.plugin timestamps,
  created:     'created_at',
  lastUpdated: 'updated_at'

{ '0': 'https://www.google.com/accounts/o8/id?id=AItOawl_5x4mzLluU_CLJe1uLhVqays4nLCR4Mc',
  '1':
   { displayName: 'Jonathon Storer',
    emails: [ [Object] ],
   name: { familyName: 'Storer', givenName: 'Jonathon' } },
   '2': [Function: verified] }










# statics
statics = concernSchema.statics
statics.findOrCreateFromAuthHash = (auth_hash, callback) ->
  findFromAuthHash auth_hash, (err, user) ->
    return callback(err, user) if err || user
    createFromAuthHash auth_hash, callback

statics.findFromAuthHash = (auth_hash, callback) ->
  Concern.findOne { age: 5}, (err, doc) ->

statics.createFromAuthHash = (auth_hash, callback) ->

# methods
concernSchema.methods.toJSON = ->
  id:       @id,
  content:  @content
  complete: @complete


module.exports = mongoose.model('Concern', concernSchema)
