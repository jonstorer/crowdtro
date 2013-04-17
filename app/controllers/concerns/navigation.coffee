Concern = require 'models/concern'

class Navigation extends Spine.Controller
  className: 'row-fluid controller'

  events:
    'click .edit':     'edit'
    'click .complete': 'complete'
    'click .pending':  'pending'
    'click .delete':   'destroy'

  constructor: ->
    super
    @html(require('views/concerns/navigation')(@concern))

    unless @concern.isPersisted()
      @concern.bind 'ajaxSuccess', =>
        @concern = Concern.findCID @concern.cid

  edit: (event) =>
    event.preventDefault()
    @navigate("concerns-#{ @concern.cid }-edit", shim: true)

  destroy: (event) =>
    event.preventDefault()
    @concern.destroy()

  complete: (event) =>
    event.preventDefault()
    @concern.complete = true
    @save()

  pending: (event) =>
    event.preventDefault()
    @concern.complete = false
    @save()

  save: =>
    @concern.bind 'save', =>
      @concern.trigger 'remove'
      Concern.trigger("concern:#{ @concern.state() }", @concern)

    @concern.save()

module.exports = Navigation
