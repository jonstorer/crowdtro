application = require('../application')
express     = require 'express'

module.exports = (app) ->
  app.configure ->
    application app, (app) ->
      app.configure 'production', ->
        app.use express.errorHandler()
