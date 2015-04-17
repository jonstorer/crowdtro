mongoose = require 'mongoose'
timestamps = require 'mongoose-times'

concernSchema = new mongoose.Schema
  content: String
  complete:
    type: Boolean
    default: false
  score:
    type: Number
    default: 0
    min: 0

# pluggins
concernSchema.plugin timestamps,
  created:     'created_at'
  lastUpdated: 'updated_at'

# methods
concernSchema.methods.toJSON = ->
  id:       @id
  content:  @content
  complete: @complete
  score:    @score

module.exports = mongoose.model('Concern', concernSchema)
