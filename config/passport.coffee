passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy
User           = require '../models/user'

passport.serializeUser   (user, done) -> done(null, user.id)
passport.deserializeUser (id, done)   -> User.findById id, done

options =
  default:
    returnURL: 'http://localhost:3000/auth/google_apps/callback',
    realm:     'http://localhost:3000/'
  production:
    returnURL: 'http://crowdtro.herokuapp.com/auth/google_apps/callback',
    realm:     'http://crowdtro.herokuapp.com/'

params = options[process.env.NODE_ENV] || options.default

passport.use new GoogleStrategy params, (identifier, profile, callback) ->
  if (new RegExp('@crowdtap.com$')).test(profile.emails[0].value)
    auth_hash = profile
    auth_hash.identifier = identifier
    User.findOrCreateFromAuthHash auth_hash, callback
  else if (new RegExp('@reenhanced.com$')).test(profile.emails[0].value)
    auth_hash = profile
    auth_hash.identifier = identifier
    User.findOrCreateFromAuthHash auth_hash, callback
  else
    callback(null, false, { message: 'Please use your crowdtap.com google apps account.' })

module.exports = passport
