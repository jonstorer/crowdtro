config = require './'

module.exports[404] = (req, res, next) ->
  res.send(404, 'Page not found')

if config.raygun
  Raygun = require('raygun')
  raygun = new Raygun.Client().init(config.raygun)
  module.exports[500] = raygun.expressHandler
else
  module.exports[500] = (err, req, res, next) ->
    res.send(500, err.message)
