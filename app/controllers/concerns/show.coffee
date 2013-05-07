Concern = require 'models/concern'

class Show extends Spine.Controller
  className: 'row-fluid controller show-concern'

  constructor: ->
    super
    @active ->
      @html require('views/concerns/show')(Concern.findCID @stack.concern.cid)

module.exports = Show
