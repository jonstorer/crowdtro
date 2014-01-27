mongoose = require('./db')
timestamps = require 'mongoose-times'

userSchema = new mongoose.Schema
  google_id:  String
  email:      String
  first_name: String
  last_name:  String
  company:
    type: mongoose.Schema.Types.ObjectId
    ref: 'Company'

userSchema.plugin timestamps,
  created:     'created_at',
  lastUpdated: 'updated_at'

userSchema.statics.findOrCreateFromAuthHash = (auth_hash, callback) ->
  auth_hash.google_id      = auth_hash.identifier
  @model('User').findFromAuthHash auth_hash, (err, user) =>
    return callback(err, user) if err || user
    @model('User').createFromAuthHash auth_hash, callback

userSchema.statics.findFromAuthHash = (auth_hash, callback) ->
  @model('User').findOne { google_id: auth_hash.google_id }, callback

userSchema.statics.createFromAuthHash = (auth_hash, callback) ->
  attributes =
    google_id:  auth_hash.google_id
    first_name: auth_hash.name.givenName
    last_name:  auth_hash.name.familyName
    email:      auth_hash.emails[0].value
    company:    auth_hash.company.id
  @model('User').create attributes, callback

# methods
userSchema.methods.toJSON = ->
  id:         @id
  first_name: @first_name

module.exports = mongoose.model('User', userSchema)
