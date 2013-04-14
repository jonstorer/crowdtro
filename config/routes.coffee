homes        = require('../routes/homes')
auth         = require('../routes/auth')
concern      = require('../routes/concern')
me           = require('../routes/me')
spine        = require('../routes/spine')
authenticate = require('../routes/middleware').authenticate
passport     = require('./passport')

module.exports = (app) ->

  app.all /^\/((?!auth|login|stylesheets|javascripts).*)/, authenticate

  app.get '/',        homes.show
  app.get '/login',   homes.login
  app.get '/logout',  homes.logout

  strategy = passport.authenticate('google', { failureRedirect: '/login', failureFlash: true })

  app.get '/auth/google_apps',          strategy
  app.get '/auth/google_apps/callback', strategy, auth.callback

  app.get '/me', me.show

  app.get    '/concerns',     concern.index
  app.post   '/concerns',     concern.create
  app.put    '/concerns/:id', concern.update
  app.delete '/concerns/:id', concern.delete

  app.get '/crowdtro.css', spine.css
  app.get '/crowdtro.js',  spine.js
