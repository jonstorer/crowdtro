Concern = require 'models/concern'

class Edit extends Spine.Controller
  className: 'row-fluid controller edit-concern'

  events:
    'submit form':   'save'
    'click .cancel': 'cancel'

  elements:
    'form': 'form'

  constructor: ->
    super
    @active -> @html require('views/concerns/edit')(Concern.findCID @stack.concern.cid)

  save: (e) =>
    e.preventDefault()

    concern = Concern.findCID @stack.concern.cid
    concern.one 'save', =>
      @navigate("concerns-#{ concern.cid }-show", { shim: true })

    concern.fromForm(e.target).save()

  cancel: (e) =>
    e.preventDefault()
    @form[0].reset()
    @navigate("concerns-#{ @stack.concern.cid }-show", { shim: true })

module.exports = Edit
