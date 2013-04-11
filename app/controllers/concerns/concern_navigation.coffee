Concern = require 'models/concern'

class ConcernNavigation extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'click .edit': 'showEdit'

  constructor: ->
    super

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @render()
    @render()

  render: =>
    @html require 'views/concerns/navigation'

  showEdit: (event) =>
    event.preventDefault()
    console.log "concerns-#{@concern.id}-edit"
    @navigate("concerns-#{@concern.id}-edit", shim: true)

module.exports = ConcernNavigation
