passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy
User           = require '../models/user'

passport.serializeUser   (user, done) -> done(null, user.id)
passport.deserializeUser (id, done)   -> User.findById id, done

options =
  returnURL: 'http://localhost:3000/auth/google_apps/callback',
  realm: 'http://localhost:3000/'

session = require('../routes/session')

passport.use new GoogleStrategy(options, session.create)

module.exports = passport
