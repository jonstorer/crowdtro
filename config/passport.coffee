passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy
User           = require '../models/user'

passport.serializeUser   (user, done) -> done(null, user.id)
passport.deserializeUser (id, done)   -> User.findById id, done

options =
  returnURL: 'http://localhost:3000/auth/google_apps/callback',
  realm:     'http://localhost:3000/'

passport.use new GoogleStrategy options,  (identifier, profile, callback) ->
  if (new RegExp('(crowdtap.com)$')).test(profile.emails[0].value)
    auth_hash = profile
    auth_hash.identifier = identifier
    User.findOrCreateFromAuthHash auth_hash, callback
  else
    callback(null, false, { message: 'Please use your crowdtap.com google apps account.' })

module.exports = passport
