passport       = require('passport')
GoogleStrategy = require('passport-google-oauth').OAuth2Strategy
config         = require('../config')
User           = require('../models').User
homes          = require('./homes')
concern        = require('./concern')
me             = require('./me')
spine          = require('./spine')


app = require('express')()

app.get '/login', homes.login
app.get '/logout', homes.logout

app.get '/auth/google',          passport.authenticate 'google', scope: 'email', hd: 'crowdtap.com'
app.get '/auth/google/callback', passport.authenticate 'google', successRedirect: '/', failureRedirect: '/login', failureFlash: true

passport.serializeUser   (user, done) -> done(null, user.id)
passport.deserializeUser (id, done) -> User.findById id, done

if config.google
  passport.use new GoogleStrategy config.google, (accessToken, refreshToken, profile, done) ->
    profile.accessToken = accessToken
    profile.refreshToken = refreshToken
    User.findOrCreateFromAuthHash profile, done

else
  app.get '/login_for_test/:id', (req, res, next) ->
    User.findById req.route.params.id, (err, user) ->
      return next err if err?
      req.login user, (err) ->
        return next err if err?
        res.json user

app.all '*', (req, res, next) ->
  return next() if req.user
  res.redirect('/login')

app.get '/me', me.show

app.get '/concerns', concern.index
app.get '/concerns/:id', concern.show
app.post '/concerns', concern.create
app.put '/concerns/:id', concern.update
app.delete '/concerns/:id', concern.delete

app.get '/crowdtro.css', spine.css
app.get '/crowdtro.js', spine.js

app.get '/', homes.show

module.exports = app
