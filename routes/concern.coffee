Concern = require '../models/concern'

exports.index = (req, res) ->
  Concern.find (err, concerns) ->
    res.json concerns

exports.create = (req, res) ->
  concernAttributes = req.body
  delete concernAttributes.id

  Concern.create concernAttributes, (err, concern) ->
    throw err if (err)
    res.json 201, concern

exports.update = (req, res) ->
  attributes = req.body
  id = attributes.id
  delete attributes.id

  Concern.findByIdAndUpdate id, { $set: attributes }, (err, concern) ->
    throw err if err
    console.log concern
    res.json concern
