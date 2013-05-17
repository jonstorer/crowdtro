Concern = require 'models/concern'

class New extends Spine.Controller
  className: 'row-fluid concern-new'

  elements:
    'form': 'form'

  events:
    'submit form':    'save'
    'keyup textarea': 'checkKeyUp'

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

  checkKeyUp: (event) =>
    @save(event) if event.which is 13

module.exports = New
