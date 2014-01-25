application = require '../application'
express     = require 'express'
raygun      = require('raygun')
Raygun      = new raygun.Client().init({ apiKey: 'SBuL7PyTCi3Qgx2UkUqgGA==' })

module.exports = (app) ->
  app.use express.logger('dev')
  application app, (app) ->
    app.configure 'development', ->
      app.use (req, res, next) ->
        Raygun.send new Error("404 @ #{req.url}")
        res.send('Page not found', 404)
      app.use (error, req, res, next) ->
        Raygun.send error
        res.send('500: Internal Server Error', 500)
