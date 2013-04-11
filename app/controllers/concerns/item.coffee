Concern    = require 'models/concern'
Navigation = require 'controllers/concerns/navigation'
Stack      = require 'controllers/concerns/stack'

class Item extends Spine.Controller
  className: 'row-fluid controller'

  constructor: ->
    super
    @append new Navigation(concern: @concern)
    @append new Stack(concern: @concern)

    @concern.bind 'remove', => @el.remove()

    @el.attr('cid', "concern-#{ @concern.cid }")

    @concern.bind 'ajaxSuccess', =>
      @concern = Concern.findCID @concern.cid
      @setId()

    @setId()

  setId: =>
    @el.attr('id', "concern-#{ @concern.id }")

module.exports = Item
