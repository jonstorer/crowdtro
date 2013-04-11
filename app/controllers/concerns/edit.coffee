Concern = require 'models/concern'

class Edit extends Spine.Controller
  className: 'row-fluid controller edit-concern'

  events:
    'submit form': 'save'

  constructor: ->
    super
    @html require('views/concerns/edit')(@stack.concern)

  save: =>
    event.preventDefault()
    @stack.concern.one 'save', =>
      @navigate("concerns-#{ @stack.concern.cid }-show")

    @stack.concern.fromForm(event.target).save()

module.exports = Edit
