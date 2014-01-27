Spine = require('spine')

class Company extends Spine.Model
  @configure 'Company', 'id', 'name', 'domain'
  @extend Spine.Model.Ajax
  @url: '/company'
  url: '/company'

module.exports = Company
