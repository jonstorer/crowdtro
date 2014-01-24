application = require('../application')
express     = require 'express'
raygun      = require('raygun')
Raygun      = new raygun.Client().init({ apiKey: 'SBuL7PyTCi3Qgx2UkUqgGA==' })

module.exports = (app) ->
  app.configure ->
    application app, (app) ->
      app.configure 'production', ->

      app.use (req, res, next) ->
        Raygun.send new Error("404 @ #{req.url}")
        res.send(404, '404: Page not found')

      app.use (error, req, res, next) ->
        Raygun.send error
        res.send(500, '500: Internal Server Error')
