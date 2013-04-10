Concern = require 'models/concern'

ConcernItem = require 'controllers/concerns/concern_item'

class ConcernList extends Spine.Controller
  className: 'row-fluid'

  constructor: ->
    super
    @el.addClass @type
    Concern.bind 'refresh', @renderAll

    switch @type
      when 'pending'
        Concern.bind 'concern:pending', @renderOne
      when 'complete'
        Concern.bind 'concern:complete', @renderOne

  renderAll: =>
    @renderOne(concern) for concern in Concern[@type]()

  renderOne: (concern) =>
    @append new ConcernItem(concern: concern)

module.exports = ConcernList
