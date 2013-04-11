Concern = require 'models/concern'

class Navigation extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'click .edit':     'showEdit'
    'click .complete': 'complete'
    'click .pending':  'pending'

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


  save: =>
    @concern.save()
    Concern.trigger("#{@concern.id}-remove")
    Concern.trigger("concern:#{@concern.state()}", @concern)

  complete: =>
    @concern.complete = true
    @save()

  pending: =>
    @concern.complete = false
    @save()

module.exports = Navigation
