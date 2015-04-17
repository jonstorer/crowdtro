require './config/monitoring'

config   = require './config'
handle   = require './config/handlers'
express  = require 'express'
flash    = require 'connect-flash'
path     = require 'path'
passport = require 'passport'

app = require('express')()
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'ejs'
app.use express.logger(config.logger)
app.use express.favicon()
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser(config.cookie.secret)
app.use express.session(config.session)
app.use passport.initialize()
app.use passport.session()
app.use express.static path.join(__dirname, 'public')
app.use flash()
app.use require('./routes')
app.use handle[404]
app.use handle[500]

app.listen config.port, ->
  console.log 'Express server listening on port', config.port
