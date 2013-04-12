require './config/monitoring'

express = require('express')
http    = require('http')
path    = require('path')
app     = express()

passport       = require('passport')
GoogleStrategy = require('passport-google').Strategy

passport.serializeUser (user, done) ->
  console.log user
  done(null, user)

passport.deserializeUser (obj, done) ->
  console.log obj
  done(null, obj)

options =
  returnURL: 'http://localhost:3000/auth/google_apps/return',
  realm: 'http://localhost:3000/'

passport.use new GoogleStrategy options, (identifier, profile, done) ->
  console.log arguments
  done(null, profile)

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('super-sekret')
  app.use express.session({ secret: 'sekret-so-super' })
  # Initialize Passport!  Also use passport.session() middleware, to support
  # persistent login sessions (recommended).
  app.use passport.initialize()
  app.use passport.session()

  app.use app.router
  app.use express.static path.join(__dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

concern = require('./routes/concern')
spine   = require('./routes/spine')

ensureAuthenticated = (req, res, next) ->
  if (req.isAuthenticated())
    next()
  else
    res.redirect('/login')

app.get '/', ensureAuthenticated, (req, res) ->
  res.status(200).sendfile path.join __dirname, 'public', 'index.html'

app.get '/login', (req, res) ->
  res.status(200).sendfile path.join __dirname, 'public', 'login.html'

app.get '/auth/google_apps', passport.authenticate('google', { failureRedirect: '/login' }), (req, res) ->
  res.redirect('/')

app.get '/auth/google_apps/return', passport.authenticate('google', { failureRedirect: '/login' }), (req, res) ->
  res.redirect('/')

app.get '/logout', (req, res) ->
  req.logout()
  res.redirect('/')

app.get    '/concerns',     concern.index
app.post   '/concerns',     concern.create
app.put    '/concerns/:id', concern.update
app.delete '/concerns/:id', concern.delete

app.get '/crowdtro.css', spine.css
app.get '/crowdtro.js',  spine.js

http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
