mongoose   = require './db'
timestamps = require 'mongoose-times'

concernSchema = new mongoose.Schema
  content: String
  complete:
    type: Boolean
    default: false

# pluggins
concernSchema.plugin timestamps,
  created:     'created_at',
  lastUpdated: 'updated_at'

# methods
concernSchema.methods.toJSON = ->
  id:       @id,
  content:  @content
  complete: @complete

module.exports = mongoose.model('Concern', concernSchema)
