Concern = require 'models/concern'

Show = require 'controllers/concerns/show'
Edit = require 'controllers/concerns/edit'

class Stack extends Spine.Stack
  className: 'row stack'

  controllers:
    show: Show
    edit: Edit

  default: 'show'

  constructor: (options) ->
    @routes["concerns-#{ options.concern.cid }-show"] = 'show'
    @routes["concerns-#{ options.concern.cid }-edit"] = 'edit'

    super

module.exports = Stack
