Concern = require 'models/concern'

class Navigation extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'click .edit':     'showEdit'
    'click .complete': 'complete'
    'click .pending':  'pending'
    'click .delete':   'destroy'

  constructor: ->
    super

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @render()
    @render()

  render: =>
    @html(require('views/concerns/navigation')(@concern))

  showEdit: (event) =>
    event.preventDefault()
    @navigate("concerns-#{@concern.id}-edit", shim: true)

  destroy: =>
    @concern.destroy()
    Concern.trigger("#{@concern.id}-remove")

  complete: (event) =>
    event.preventDefault()
    @concern.complete = true
    @save()

  pending: (event) =>
    event.preventDefault()
    @concern.complete = false
    @save()

  save: =>
    @concern.save()
    Concern.trigger("#{@concern.id}-remove")
    Concern.trigger("concern:#{@concern.state()}", @concern)

module.exports = Navigation
