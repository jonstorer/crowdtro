express     = require 'express'
raygun      = require('raygun')
Raygun      = new raygun.Client().init({ apiKey: 'SBuL7PyTCi3Qgx2UkUqgGA==' })

module.exports = (app) ->
  app.configure ->
    app.use (req, res, next) ->
      Raygun.send new Error("404 @ #{req.url}")
      res.send(404, '404: Page not found')

    app.use Raygun.expressHandler
