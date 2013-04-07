require('lib/setup')

Spine = require('spine')

ConcernsController = require 'controllers/concerns_controller'

class Crowdtro extends Spine.Controller
  elements:
    '#concerns': 'concerns'

  constructor: ->
    super

    @html require 'views'
    @concerns.html new ConcernsController().el

module.exports = Crowdtro
