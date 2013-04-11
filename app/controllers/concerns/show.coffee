Concern = require 'models/concern'

class ConcernShow extends Spine.Controller
  className: 'row-fluid controller show-concern'

  constructor: ->
    super
    @html require('views/concerns/show')(@stack.concern)

module.exports = ConcernShow
