application = require('../application')
express     = require 'express'

module.exports = (app) ->
  app.use express.logger('dev')
  application app
  app.configure 'development', ->
    app.use express.errorHandler()
