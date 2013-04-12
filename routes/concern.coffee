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
  id = req.route.params.id
  attributes = req.body
  delete attributes.id

  Concern.findByIdAndUpdate id, { $set: attributes }, (err, concern) ->
    throw err if err
    res.json concern

exports.delete = (req, res) ->
  id = req.route.params.id
  attributes = req.body
  delete attributes.id

  Concern.findByIdAndRemove id, (err, concern) ->
    throw err if err
    res.json concern
