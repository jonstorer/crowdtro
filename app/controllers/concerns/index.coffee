Concern = require 'models/concern'

ConcernsList = require 'controllers/concerns/concerns_list'
NewConcern   = require 'controllers/concerns/new_concern'

class ConcernsController extends Spine.Controller
  className: 'container-fluid'

  constructor: ->
    super

    @append new ConcernsList type: 'pending'
    @append new NewConcern
    @append new ConcernsList type: 'complete'

    Concern.fetch()

module.exports = ConcernsController
