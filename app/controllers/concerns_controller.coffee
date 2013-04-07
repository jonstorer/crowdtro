Concern = require 'models/concern'
CurrentConcernController = require 'controllers/current_concern_controller'
OldConcernController     = require 'controllers/old_concern_controller'

class ConcernsController extends Spine.Controller
  elements:
    'form#new-concern': 'form'
    '#current-concerns': 'currentConcerns'
    '#old-concerns':     'oldConcerns'

  events:
    'submit form': 'save'

  constructor: ->
    super

    @html require 'views/concerns'

    Concern.bind 'refresh', @renderAll
    Concern.fetch()

  renderAll: =>
    @renderOne(concern) for concern in Concern.all()

  renderOne: (concern) =>
    concern.one 'complete incomplete', @renderOne

    switch concern.complete
      when true
        @oldConcerns.prepend((new OldConcernController(concern: concern)).el)
      else
        @currentConcerns.append((new CurrentConcernController(concern: concern)).el)

  save: (event) =>
    event.preventDefault()
    concern = new Concern
    concern.one 'save', =>
      @renderOne(concern)
      @form[0].reset()

    concern.fromForm(@form).save()


module.exports = ConcernsController
