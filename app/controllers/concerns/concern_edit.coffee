Concern = require 'models/concern'

class ConcernItem extends Spine.Controller
  className: 'row-fluid'

  elements:
    'input[type="checkbox"]': 'checkbox'

  events:
    'change input': 'complete'

  constructor: ->
    super
    @concern = @stack.concern

    @html require('views/concerns/edit')(@concern)
    @setElId()

  setElId: =>
    @el.attr('id', "concern-#{@concern.id}-edit")

  complete: =>
    @concern.complete = @checkbox.is(':checked')
    @concern.save()
    Concern.trigger("concern:#{@concern.state()}", @concern)
    @el.remove()

module.exports = ConcernItem
