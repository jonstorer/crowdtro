Hem = require 'hem'
hem = new Hem()

exports.js = (req, res) ->
  res.set('Content-Type', 'text/javascript')
  res.send hem.hemPackage().compile()

exports.css = (req, res) ->
  res.set('Content-Type', 'text/css')
  res.send hem.cssPackage().compile()
