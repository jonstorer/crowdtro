Concern    = require 'models/concern'
Navigation = require 'controllers/concerns/navigation'
Stack      = require 'controllers/concerns/stack'

class Item extends Spine.Controller
  className: 'row-fluid controller concern-item'

  constructor: ->
    super
    @append new Stack(concern: @concern)
    @append new Navigation(concern: @concern)

    @concern.bind 'unbind remove', => @el.remove()

    @el.attr('cid', "concern-#{ @concern.cid }")

    unless @concern.isPersisted()
      @concern.bind 'ajaxSuccess', =>
        @concern = Concern.findCID @concern.cid
        @setId()

    @setId()

  setId: =>
    @el.attr('id', "concern-#{ @concern.id }")

module.exports = Item
