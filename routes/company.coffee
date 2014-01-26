Company = require('mongoose').models.Company

exports.show = (req, res) ->
  Company.findById req.session.company.id, (err, company) ->
    throw err if err
    res.json company
