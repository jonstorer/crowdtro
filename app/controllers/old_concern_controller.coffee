Concern = require 'models/concern'

class OldConcernController extends Spine.Controller
  elements:
    'input[type="checkbox"]': 'checkbox'

  events:
    'change input': 'complete'

  constructor: ->
    super
    @html require('views/concerns/old_concern')(@concern)

  complete: =>
    @concern.complete = @checkbox.is(':checked')
    @concern.save()
    @concern.trigger('complete')
    @el.remove()

module.exports = OldConcernController
