application = require '../application'
express     = require 'express'

module.exports = (app) ->
  app.configure ->
    app.use express.logger('dev')
    app.use (req, res, next) ->
      res.send('Page not found', 404)
    app.use (error, req, res, next) ->
      res.send('500: Internal Server Error', 500)
