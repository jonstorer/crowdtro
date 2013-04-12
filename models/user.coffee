mongoose = require('./db')

userSchema = new mongoose.Schema
  email:      String
  first_name: String
  last_name:  String

concernSchema.plugin timestamps,
  created:     'created_at',
  lastUpdated: 'updated_at'

module.exports = mongoose.model('User', userSchema)
