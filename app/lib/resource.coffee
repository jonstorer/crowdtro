Spine = require('spine')
Ajax  = Spine.Ajax
Model = Spine.Model

Include =
  url: (args...) ->
    url = Ajax.getURL(@constructor)
    url = url.substring(0, str.length - 1) if url.charAt(url.length - 1) is '/'
    args.unshift(url)
    args.join('/')

Extend =
  url: (args...) ->
    args.unshift(@className.toLowerCase())
    args.unshift(Model.host)
    args.join('/')

Resource =
  extended: ->
    @extend Extend
    @include Include
    @

module.exports = Resource
