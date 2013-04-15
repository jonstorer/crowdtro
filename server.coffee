env = process.env.NODE_ENV || 'development'

require './config/monitoring'

app = require('express')()

require("./config/environments/#{env}")(app)
require('./config/routes')(app)

http = require('http')
http.createServer(app).listen app.get('port'), ->
  console.log('Express server listening on port ' + app.get('port'))
