Me      = require 'models/me'
Company = require 'models/company'

class HeaderController extends Spine.Controller
  className: 'navbar navbar-inverse navbar-fixed-top'

  attributes:
    id: 'header'

  events:
    'click a.brand':           'showEditCompany'
    'keyup form#edit_company': 'checkKeyUp'
    'submit form':             (e) -> e.preventDefault()

  elements:
    'a.brand':                 'brandLink'
    'form#edit_company':       'form'
    'form#edit_company input': 'field'

  constructor: ->
    super

    Me.one 'refresh', =>
      Company.bind 'refresh', @render
      Company.fetch()
    Me.fetch()

  render: =>
    @html require('views/header')(me: Me.last(), company: Company.last())

  showEditCompany: (e) ->
    e.preventDefault()
    @brandLink.hide()
    @form.show()
    @field.focus()

  checkKeyUp: (e) =>
    if e.which is 13
      e.preventDefault()
      company = Company.last()
      company.fromForm e.currentTarget
      company.one 'save', @render
      company.save()
    else if e.which is 27
      @render()

module.exports = HeaderController
