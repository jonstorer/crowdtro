Concern    = require 'models/concern'
Navigation = require 'controllers/concerns/navigation'
Stack      = require 'controllers/concerns/stack'

class Item extends Spine.Controller
  className: 'row-fluid controller concern-item'

  constructor: ->
    super
    @append new Stack(concern: @concern)
    @append new Navigation(concern: @concern)

    @concern.bind 'unbind remove', => @release()

    @setId @concern.id

    @el.attr('cid', "concern-#{ @concern.cid }")

    unless @concern.isPersisted()
      Concern.bind 'ajaxSuccess', (_, concern) =>
        @concern = Concern.findCID @concern.cid
        @setId @concern.id
        Concern.unbind 'ajaxSuccess' if @concern.isPersisted()

  setId: (id) => @el.attr('id', "concern-#{ id }")

module.exports = Item
