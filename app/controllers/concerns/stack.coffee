Concern = require 'models/concern'

Show = require 'controllers/concerns/show'
Edit = require 'controllers/concerns/edit'

class Stack extends Spine.Stack
  className: 'row-fluid stack'

  controllers:
    show: Show
    edit: Edit

  default: 'show'

  constructor: (options) ->
    @routes["concerns-#{ options.concern.cid }-show"] = 'show'
    @routes["concerns-#{ options.concern.cid }-edit"] = 'edit'

    super

    @concern.bind 'ajaxSuccess', =>
      @concern = Concern.findCID @concern.cid

    @concern.bind 'save', => @concern.reload()

module.exports = Stack
