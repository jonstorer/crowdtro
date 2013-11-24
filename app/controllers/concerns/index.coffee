Concern = require 'models/concern'

List = require 'controllers/concerns/list'
New  = require 'controllers/concerns/new'

class ConcernsController extends Spine.Controller
  className: 'container-fluid concerns'

  events:
    'click .load': 'load'

  elements:
    'a.load': 'loadLink'

  constructor: ->
    super

    @append new List type: 'pending'
    @append new New
    @append require 'views/concerns/load'
    @append new List type: 'complete'

    Concern.bind 'refresh', (concerns) =>
      for concern in concerns
        Concern.trigger "concern:#{concern.state()}", concern
    Concern.fetch(data: 'complete=false')

  load: (e) ->
    e.preventDefault()
    @loadLink.remove()
    Concern.fetch(data: 'complete=true')

module.exports = ConcernsController
