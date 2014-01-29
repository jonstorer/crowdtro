mongoose   = require './db'
timestamps = require 'mongoose-times'

companySchema = new mongoose.Schema
  name:  String
  domain:
    type:  String
    match: /.+@.+$/

# pluggins
companySchema.plugin timestamps,
  created:     'created_at'
  lastUpdated: 'updated_at'

module.exports = mongoose.model('Company', companySchema)
