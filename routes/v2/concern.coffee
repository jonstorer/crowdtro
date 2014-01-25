Concern = require('mongoose').models.Concern

exports.index = (req, res) ->
  query = JSON.parse(JSON.stringify(req.query || {}))
  query.company = req.session.company.id

  Concern.find query, (err, concerns) ->
    res.json concerns

exports.show = (req, res) ->
  query =
    _id:     req.route.params.id
    copmany: req.session.company.id

  Concern.findOne query, (err, concern) ->
    throw err if err
    res.json concern

exports.create = (req, res) ->
  params = req.body
  delete params.id
  params.company = req.session.company.id

  Concern.create params, (err, concern) ->
    throw err if (err)
    res.json 201, concern

exports.update = (req, res) ->
  query =
    _id:     req.route.params.id
    company: req.session.company.id

  attributes = req.body
  delete attributes.id

  Concern.findOneAndUpdate query, attributes, (err, concern) ->
    throw err if err
    res.json concern

exports.delete = (req, res) ->
  query =
    _id:     req.route.params.id
    company: req.session.company.id

  Concern.findOneAndRemove query, (err, concern) ->
    throw err if err
    res.json concern
