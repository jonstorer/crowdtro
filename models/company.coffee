mongoose   = require './db'
timestamps = require 'mongoose-times'

companySchema = new mongoose.Schema
  name: String
  domain:
    type:     String
    validate: new RegExp(/[^@]+$/i)

# pluggins
companySchema.plugin timestamps,
  created:     'created_at'
  lastUpdated: 'updated_at'

# statics
companySchema.statics.findOrCreate = (params, callback) ->
  @model('Company').findOne params, (err, company) =>
    if err || company
      callback(err, company) 
    else
      @model('Company').create params, callback

# methods
companySchema.methods.toJSON = ->
  id:     @id
  name:   @name
  domain: @domain

module.exports = mongoose.model('Company', companySchema)
