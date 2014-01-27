Company = require('mongoose').models.Company

exports.show = (req, res) ->
  Company.findById req.session.company.id, (err, company) ->
    throw err if err
    res.json company

exports.update = (req, res) ->
  params = req.body
  id     = params.id
  delete params.id
  Company.findByIdAndUpdate id, params, (err, company) ->
    throw err if err
    res.json company
