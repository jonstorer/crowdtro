Spine = require('spine')

class Concern extends Spine.Model
  @configure 'Concern', 'id', 'content', 'complete'

  @extend Spine.Model.Ajax

  state: ->
    if @complete then 'complete' else 'pending'

  isComplete: -> @complete == true

  isPersisted: -> @cid == @id

  @complete: ->
    @select (c) -> c.complete == true

  @pending: ->
    @select (c) -> c.complete != true

module.exports = Concern
