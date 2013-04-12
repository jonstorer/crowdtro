mongoose = require('./db')

userSchema = new mongoose.Schema
  email:      String
  first_name: String
  last_name:  String

module.exports = mongoose.model('User', userSchema)
