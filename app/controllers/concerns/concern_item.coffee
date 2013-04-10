Concern = require 'models/concern'

ConcernShow = require 'controllers/concerns/concern_show'
ConcernEdit = require 'controllers/concerns/concern_edit'

class ConcernList extends Spine.Stack
  className: 'row-fluid stack'

  controllers:
    show: ConcernShow
    edit: ConcernEdit

  default: 'show'

  constructor: (options) ->
    @routes["concerns-#{options.concern.id}-show"] = 'show'
    @routes["concerns-#{options.concern.id}-edit"] = 'edit'

    super

module.exports = ConcernList
