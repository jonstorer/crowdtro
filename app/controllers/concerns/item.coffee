Concern    = require 'models/concern'
Navigation = require 'controllers/concerns/navigation'
Stack      = require 'controllers/concerns/stack'

class Item extends Spine.Controller
  className: 'row-fluid controller concern-item'

  constructor: ->
    super
    @append new Stack(concern: @concern)
    @append new Navigation(concern: @concern)

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @setElId()
      @bindRemove()

    @setElId()
    @bindRemove()

  bindRemove: =>
    Concern.bind "#{@concern.id}-remove", => @el.remove()

  setElId: =>
    @el.attr('id', "concern-#{ @concern.id }")

module.exports = Item
