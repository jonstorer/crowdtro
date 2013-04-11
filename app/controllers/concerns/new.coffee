Concern = require 'models/concern'

class New extends Spine.Controller
  elements:
    'form': 'form'

  events:
    'submit form': 'save'

  constructor: ->
    super
    @html require 'views/concerns/new'

  save: (event) =>
    event.preventDefault()
    concern = (new Concern).fromForm(@form)
    concern.one 'save', =>
      Concern.trigger "concern:#{concern.state()}", concern
      @form[0].reset()

    concern.save()

module.exports = New
