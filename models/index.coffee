config = require '../config'

require('mongoose').connect config.mongo.url, ->
  console.log 'connected to', config.mongo.url

require('fs-readdir-recursive')(__dirname).forEach (file) ->
  if !file.match(/^index/)
    if model = require("./#{file}")
      if model.modelName
        module.exports[model.modelName] = model
