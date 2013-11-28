Concern = require 'models/concern'

List = require 'controllers/concerns/list'
New  = require 'controllers/concerns/new'

class ConcernsController extends Spine.Controller
  className: 'container-fluid concerns'

  constructor: ->
    super

    @append new List type: 'pending'
    @append new New
    @append new List type: 'complete'

    Concern.bind 'refresh', (concerns) =>
      for concern in concerns
        Concern.trigger "concern:#{concern.state()}", concern

    Concern.one 'refresh', ->
      Concern.fetch(data: 'complete=true')

    Concern.fetch(data: 'complete=false')

module.exports = ConcernsController
