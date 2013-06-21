mongoose   = require('mongoose')
env        = process.env.NODE_ENV or 'development'
mongo_port = process.env.BOXEN_MONGODB_PORT or 27017

switch(env)
  when 'development'
    mongo_uri = "mongodb://localhost:#{mongo_port}/crowdtro_development"
  when 'test'
    mongo_uri = "mongodb://localhost:#{mongo_port}/crowdtro_test_#{process.env.PORT}"
  when 'production'
    mongo_uri = process.env.MONGOLAB_URI

mongoose.connect mongo_uri, (err, res) ->
  if err
    console.log "ERROR connecting to: #{mongo_uri}. #{err}"
  else
    console.log "Mongooose connected to: #{mongo_uri}"

module.exports = mongoose
