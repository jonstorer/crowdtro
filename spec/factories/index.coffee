fs = require 'fs'
require "../../models/#{file}" for file in fs.readdirSync('./models')
mongoose = require 'mongoose'

#used = {}

#s4   = -> Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
#uuid = -> s4() + s4() + s4() + s4() + s4() + s4() + s4()

#guid = ->
  #id = uuid()
  #id = uuid() while used[id]?
  #used[id] = true
  #id

Factory = require('rosie').Factory

# Company
Factory.define('Company', mongoose.models.Company)
  .attr('name',    'Test Company')
  .attr('domain',  'example.com')

# User
Factory.define('User', mongoose.models.User)
  .sequence('google_apps_id')
  .sequence('email', (n) -> "user_#{n}#exampel.com")
  .attr('first_name',  'Jon')
  .attr('last_name',   'Doe')
  #.attr('company',  -> Factory.attributes('Company') )
