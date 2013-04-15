application = require('../application')
express     = require 'express'
User        = require '../../models/user'

module.exports = (app) ->
  app.configure ->
    application app, (app) ->
      app.configure 'test', ->
        app.use express.errorHandler()
        app.post '/login_for_test/:id', (req, res) ->
          id = req.route.params.id
          User.findById id, (err, user) ->
            console.log err if err
            req.login user, (err) ->
              if err
                console.log err
                res.send(500, { error: 'could not log in' })
              else
                res.json 200, user
