Spine = require('spine')

class Company extends Spine.Model
  @configure 'Company', 'id', 'name', 'domain'
  @extend Spine.Model.Ajax
  @url: '/v2/company'

module.exports = Company
