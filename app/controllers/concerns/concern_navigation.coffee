class ConcernNavigation extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'click .edit': 'showEdit'

  constructor: ->
    super
    @html require 'views/concerns/navigation'

  showEdit: (event) =>
    event.preventDefault()
    @navigate("concerns-#{@concern.id}-edit", shim: true)

module.exports = ConcernNavigation
