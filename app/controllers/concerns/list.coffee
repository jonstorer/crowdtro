Concern = require 'models/concern'

Item = require 'controllers/concerns/item'

class List extends Spine.Controller
  className: 'row-fluid'

  constructor: ->
    super
    @el.addClass @type
    Concern.bind "concern:#{@type}", (concern) =>
      @append new Item(concern: concern)

module.exports = List
