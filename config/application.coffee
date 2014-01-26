passport = require 'passport'
express  = require 'express'
flash    = require 'connect-flash'
path     = require('path')
fs       = require 'fs'
mongoose = require 'mongoose'

module.exports = (app, next) ->
  app.configure ->
    require "../models/#{file}" for file in fs.readdirSync('./models')

    app.set 'views', path.join(__dirname, '..', 'views')
    app.set 'view engine', 'ejs'
    app.set 'port', process.env.PORT || 3030
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use express.cookieParser('super-sekret')
    app.use express.session({ secret: 'sekret-so-super' })

    app.use (req, res, next) ->
      if !req.session.company? && id = req.session.passport?.user
        mongoose.models.User.findById id, (err, user) ->
          req.session.company ||= { id: user.company }
          next()
      else
        next()

    app.use flash()
    app.use passport.initialize()
    app.use passport.session()
    app.use app.router
    app.use express.static path.join(__dirname, '..', 'public')

    next(app)
