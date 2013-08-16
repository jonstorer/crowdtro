homes        = require('../routes/homes')
concern      = require('../routes/concern')
me           = require('../routes/me')
spine        = require('../routes/spine')
angular      = require('../routes/angular')
authenticate = require('../routes/middleware').authenticate
passport     = require('./passport')

module.exports = (app) ->

  routes = 'auth|login|img|stylesheets|javascripts'
  routes += '|login_for_test' if process.env.NODE_ENV == 'test'
  routes = new RegExp("^\/((?!#{routes}).*)")

  app.all routes, authenticate

  app.get '/',        homes.show
  app.get '/login',   homes.login
  app.get '/logout',  homes.logout

  strategy = passport.authenticate 'google',
    successRedirect: '/old.html'
    failureRedirect: '/login'
    failureFlash:    true

  app.get '/auth/google_apps',          strategy
  app.get '/auth/google_apps/callback', strategy

  app.get '/me', me.show

  app.get    '/concerns',     concern.index
  app.get    '/concerns/:id', concern.show
  app.post   '/concerns',     concern.create
  app.put    '/concerns/:id', concern.update
  app.delete '/concerns/:id', concern.delete

  app.get '/crowdtro.css', spine.css
  app.get '/crowdtro.js',  spine.js

  app.get '/v2/crowdtro.js',  angular.js
