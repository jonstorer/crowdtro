require('lib/setup')

Spine    = require('spine')
Concerns = require 'controllers/concerns'
Header   = require 'controllers/header'

class Crowdtro extends Spine.Controller
  constructor: ->
    super

    @html   new Header
    @append new Concerns
    @append require 'views/footer'

module.exports = Crowdtro
