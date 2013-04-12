mongoose = require('./db')
timestamps = require 'mongoose-times'

userSchema = new mongoose.Schema
  google_apps_id: String
  email:          String
  first_name:     String
  last_name:      String

userSchema.plugin timestamps,
  created:     'created_at',
  lastUpdated: 'updated_at'

userSchema.statics.findOrCreateFromAuthHash = (auth_hash, callback) ->
  auth_hash.google_apps_id = auth_hash.identifier.match(new RegExp('id=(.+)$'))[1]
  @model('User').findFromAuthHash auth_hash, (err, user) =>
    return callback(err, user) if err || user
    @model('User').createFromAuthHash auth_hash, callback

userSchema.statics.findFromAuthHash = (auth_hash, callback) ->
  @model('User').findOne { google_apps_id: auth_hash.google_app_id }, callback

userSchema.statics.createFromAuthHash = (auth_hash, callback) ->
  attributes =
    google_app_id: auth_hash.google_apps_id
    first_name:    auth_hash.name.givenName
    last_name:     auth_hash.name.familyName
    email:         auth_hash.emails[0].value
  @model('User').create attributes, callback

module.exports = mongoose.model('User', userSchema)
