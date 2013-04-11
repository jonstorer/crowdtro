Concern = require 'models/concern'

class ConcernShow extends Spine.Controller
  className: 'row-fluid controller show-concern'

  constructor: ->
    super
    @concern = @stack.concern
    @render()

  active: =>
    super
    @concern = Concern.findCID @concern.cid
    @render()

  render: =>
    @html require('views/concerns/show')(@concern)

module.exports = ConcernShow
