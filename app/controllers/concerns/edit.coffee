Concern = require 'models/concern'

class Edit extends Spine.Controller
  className: 'row-fluid controller edit-concern'

  events:
    'submit form': 'save'

  constructor: ->
    super
    @concern = @stack.concern
    @render()

  active: =>
    super
    @concern = Concern.findCID @concern.cid
    @render()

  render: =>
    @html require('views/concerns/edit')(@concern)

  save: =>
    event.preventDefault()
    @concern.one 'save', =>
      @navigate("concerns-#{@concern.id}-show", shim: true)

    @concern.fromForm(event.target).save()

module.exports = Edit
