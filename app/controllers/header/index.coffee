Me      = require 'models/me'
Company = require 'models/company'

class HeaderController extends Spine.Controller
  className: 'navbar navbar-inverse navbar-fixed-top'

  constructor: ->
    super

    Me.one 'refresh', =>
      Company.one 'refresh', =>
        @html require('views/header')(me: Me.last(), company: Company.last())
      Company.fetch()
    Me.fetch()

module.exports = HeaderController
