Concern = require 'models/concern'

List = require 'controllers/concerns/list'
New  = require 'controllers/concerns/new'

class ConcernsController extends Spine.Controller
  className: 'container-fluid'

  constructor: ->
    super

    @append new List type: 'pending'
    @append new New
    @append new List type: 'complete'

    Concern.fetch()

module.exports = ConcernsController
