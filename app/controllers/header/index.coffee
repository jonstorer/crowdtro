Me = require 'models/me'

class HeaderController extends Spine.Controller
  className: 'navbar navbar-inverse navbar-fixed-top'

  constructor: ->
    super

    Me.one 'refresh', =>
      @html require('views/header')(Me.last())

    Me.fetch()

module.exports = HeaderController
