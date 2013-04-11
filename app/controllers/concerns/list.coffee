Concern = require 'models/concern'

Item = require 'controllers/concerns/item'

class List extends Spine.Controller
  className: 'row-fluid'

  constructor: ->
    super
    @el.addClass @type
    Concern.bind 'refresh', @renderAll
    Concern.bind "concern:#{@type}", @renderOne

  renderAll: =>
    @renderOne(concern) for concern in Concern[@type]()

  renderOne: (concern) =>
    @append new Item(concern: concern)

module.exports = List
