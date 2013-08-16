cs = require 'coffee-script'
fs = require 'fs'

exports.js = (req, res) ->
  res.set('Content-Type', 'text/javascript')
  res.send cs.compile fs.readFileSync('./crowdtro.coffee', 'utf8')
