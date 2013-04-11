Concern           = require 'models/concern'
ConcernNavigation = require 'controllers/concerns/concern_navigation'
ConcernStack      = require 'controllers/concerns/concern_stack'

class ConcernItem extends Spine.Controller
  className: 'row-fluid controller'

  constructor: ->
    super
    @append new ConcernNavigation(concern: @concern)
    @append new ConcernStack(concern: @concern)


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

module.exports = ConcernItem
