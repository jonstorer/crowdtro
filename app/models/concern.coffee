Spine = require('spine')

class Concern extends Spine.Model
  @configure 'Concern', 'id', 'content', 'complete'

  @extend Spine.Model.Ajax

module.exports = Concern
