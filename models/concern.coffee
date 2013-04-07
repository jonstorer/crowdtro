mongoose = require('./db')

concernSchema = new mongoose.Schema
  content: String
  complete:
    type: Boolean
    default: false

concernSchema.methods.toJSON = ->
  id:       @id,
  content:  @content
  complete: @complete

module.exports = mongoose.model('Concern', concernSchema)
