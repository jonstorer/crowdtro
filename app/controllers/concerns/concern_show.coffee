Concern = require 'models/concern'

class ConcernShow extends Spine.Controller
  className: 'row-fluid controller'

  elements:
    'input[type="checkbox"]': 'checkbox'

  events:
    'change input':     'complete'
    'click .icon-edit': 'showEdit'

  constructor: ->
    super
    @concern = @stack.concern

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @setElId()

    @render()
    @setElId()

  setElId: =>
    @el.attr('id', "concern-#{@concern.id}-show")

  active: =>
    super
    @concern = Concern.findCID @concern.cid
    @render()

  render: =>
    @html require('views/concerns/show')(@concern)

  showEdit: (event) =>
    event.preventDefault()
    @navigate("concerns-#{@concern.id}-edit", shim: true)

  complete: =>
    @concern.complete = @checkbox.is(':checked')
    @concern.save()
    Concern.trigger("concern:#{@concern.state()}", @concern)
    @el.remove()

module.exports = ConcernShow
