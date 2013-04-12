passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy

passport.serializeUser   (user, done) -> done(null, user)
passport.deserializeUser (obj, done)  -> done(null, obj)

options =
  returnURL: 'http://localhost:3000/auth/google_apps/return',
  realm: 'http://localhost:3000/'

session = require('./routes/session')
passport.use new GoogleStrategy(options, session.create)
