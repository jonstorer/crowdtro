Concern = require 'models/concern'

class ConcernEdit extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'submit form': 'save'

  constructor: ->
    super
    @concern = @stack.concern

    @html require('views/concerns/edit')(@concern)
    @setElId()

  setElId: =>
    @el.attr('id', "concern-#{@concern.id}-edit")

  save: =>
    event.preventDefault()
    @concern.one 'save', =>
      @navigate("concerns-#{@concern.id}-show", shim: true)

    @concern.fromForm(event.target).save()

module.exports = ConcernEdit
