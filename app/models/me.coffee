Spine    = require('spine')
Resource = require('../lib/resource')

class Me extends Spine.Model
  @configure 'Me', 'id', 'first_name', 'last_name'

  @extend Spine.Model.Ajax
  @extend Resource
  @url: '/me'

module.exports = Me
