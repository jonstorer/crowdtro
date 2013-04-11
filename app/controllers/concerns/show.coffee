Concern = require 'models/concern'

class ConcernShow extends Spine.Controller
  className: 'row-fluid controller show-concern'

  elements:
    'input[type="checkbox"]': 'checkbox'

  events:
    'change input': 'complete'

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

  complete: =>
    @concern.complete = @checkbox.is(':checked')
    @concern.save()
    Concern.trigger("#{@concern.id}-remove")
    Concern.trigger("concern:#{@concern.state()}", @concern)

module.exports = ConcernShow
