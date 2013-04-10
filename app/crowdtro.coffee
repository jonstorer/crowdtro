require('lib/setup')

Spine    = require('spine')
Concerns = require 'controllers/concerns'

class Crowdtro extends Spine.Controller

  elements:
    '#concerns': 'concerns'

  constructor: ->
    super

    @html   require 'views/header'
    @append new Concerns
    @append require 'views/footer'

module.exports = Crowdtro
