passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy
mongoose = require 'mongoose'
User     = mongoose.models.User
Company  = mongoose.models.Company

passport.serializeUser   (user, next) -> next(null, user.id)
passport.deserializeUser (id, next)   -> User.findById id, next

options =
  default:
    returnURL: 'http://localhost:3030/auth/google_apps/callback',
    realm:     'http://localhost:3030/'
  production:
    returnURL: 'http://crowdtro.herokuapp.com/auth/google_apps/callback',
    realm:     'http://crowdtro.herokuapp.com/'

params = options[process.env.NODE_ENV] || options.default

passport.use new GoogleStrategy params, (identifier, profile, callback) ->
  if domain = profile.emails[0].value.match(new RegExp(/[^@]+$/i))
    Company.findOrCreate { domain: domain }, (err, company) ->
      auth_hash            = profile
      auth_hash.identifier = identifier
      auth_hash.company    = company
      User.findOrCreateFromAuthHash auth_hash, callback
  else
    callback(null, false, { message: 'Please use your crowdtap.com google apps account.' })

module.exports = passport
