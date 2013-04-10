Concern                  = require 'models/concern'

class NewConcern extends Spine.Controller
  elements:
    'form': 'form'

  events:
    'submit form': 'save'

  constructor: ->
    super
    @html require 'views/concerns/new'

  save: (event) =>
    event.preventDefault()
    concern = new Concern
    concern.one 'save', =>
      Concern.trigger("concern:#{concern.state()}", concern)
      @form[0].reset()

    concern.fromForm(@form).save()

module.exports = NewConcern
