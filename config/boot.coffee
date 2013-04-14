passport = require 'passport'
express  = require 'express'
flash    = require 'connect-flash'

path = require('path')

module.exports = (app) ->
  app.configure ->
    app.set 'views', path.join(__dirname, '..', 'views')
    app.set 'view engine', 'ejs'
    app.set 'port', process.env.PORT || 3000
    app.use express.favicon()
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('super-sekret')
    app.use express.session({ secret: 'sekret-so-super' })
    app.use flash()
    # Initialize Passport!  Also use passport.session() middleware, to support
    # persistent login sessions (recommended).
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router
    app.use express.static path.join(__dirname, '..', 'public')

  app.configure 'development', ->
    app.use express.errorHandler()
