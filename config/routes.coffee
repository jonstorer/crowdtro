homes        = require('../routes/homes')
auth         = require('../routes/auth')
concern      = require('../routes/concern')
spine        = require('../routes/spine')
authenitcate = require('../routes/middleware').authenticate
passport     = require('./passport')


module.exports = (app) ->

  app.get '/',       authenticate, homes.show
  app.get '/login',                homes.login
  app.get '/logout',               homes.logout

  app.get '/auth/google_apps',          passport.authenticate('google', { failureRedirect: '/login' }), auth.auth
  app.get '/auth/google_apps/callback', passport.authenticate('google', { failureRedirect: '/login' }), auth.callback

  app.get    '/concerns',     concern.index
  app.post   '/concerns',     concern.create
  app.put    '/concerns/:id', concern.update
  app.delete '/concerns/:id', concern.delete

  app.get '/crowdtro.css', spine.css
  app.get '/crowdtro.js',  spine.js
