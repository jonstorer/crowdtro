User = require '../models/user'

exports.create = (identifier, profile, done) ->
  profile.identifier = identifier
  User.findOrCreateFromAuthHash profile, (err, user) ->
    done(null, user)
