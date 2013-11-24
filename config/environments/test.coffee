application = require('../application')
express     = require 'express'
User        = require '../../models/user'

module.exports = (app) ->
  app.use express.logger('dev')
  application app
  app.configure 'test', ->
    app.use express.errorHandler()
    login = (req, res) ->
      id = req.route.params.id
      User.findById id, (err, user) ->
        console.log err if err
        req.login user, (err) ->
          if err
            console.log err
            res.send(500, { error: 'could not log in' })
          else
            res.json 200, user

    app.post '/login_for_test/:id', login
    app.get '/login_for_test/:id', login
