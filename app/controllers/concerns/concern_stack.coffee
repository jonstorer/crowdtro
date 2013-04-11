Concern = require 'models/concern'

ConcernShow = require 'controllers/concerns/concern_show'
ConcernEdit = require 'controllers/concerns/concern_edit'

class ConcernItem extends Spine.Stack
  className: 'row-fluid stack'

  controllers:
    show: ConcernShow
    edit: ConcernEdit

  default: 'show'

  constructor: (options) ->
    super

    @concern.bind 'save', =>
      @concern = Concern.findCID @concern.cid
      @setRoutes()
    @setRoutes()

  setRoutes: =>
    @routes["concerns-#{@concern.id}-show"] = 'show'
    @routes["concerns-#{@concern.id}-edit"] = 'edit'

    #this was ripped from spine internals
    for key, value of @routes
      do (key, value) =>
        callback = value if typeof value is 'function'
        callback or= => @[value].active(arguments...)
        @route(key, callback)

module.exports = ConcernItem
