express = require('express')
http    = require('http')
path    = require('path')
app     = express()

env = process.env.NODE_ENV or 'development'

app.configure ->
  app.set 'port', process.env.PORT || 3000
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('super-sekret')
  app.use express.session()
  app.use app.router
  app.use express.static path.join(__dirname, 'public')

app.configure 'development', ->
  app.use express.errorHandler()

concern = require('./routes/concern')
spine   = require('./routes/spine')

app.get  '/concerns',     concern.index
app.post '/concerns',     concern.create
app.put  '/concerns/:id', concern.update

app.get '/crowdtro.css', spine.css
app.get '/crowdtro.js',  spine.js

http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
