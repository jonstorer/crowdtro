Concern = require 'models/concern'

class CurrentConcernController extends Spine.Controller
  className: 'row-fluid'

  elements:
    'input[type="checkbox"]': 'checkbox'

  events:
    'change input': 'complete'

  constructor: ->
    super

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @setElId()

    @html require('views/concerns/current_concern')(@concern)
    @setElId()

  setElId: =>
    @el.attr('id', 'concern-' + @concern.id)

  complete: =>
    @concern.complete = @checkbox.is(':checked')
    @concern.save()
    @concern.trigger('complete')
    @el.remove()


module.exports = CurrentConcernController
