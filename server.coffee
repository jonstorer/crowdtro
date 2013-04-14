require './config/monitoring'

app = require('express')()

require('./config/boot')(app)
require('./config/routes')(app)

http = require('http')
http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
