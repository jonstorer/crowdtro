should   = require 'should'
mongoose = require '../../models/db'
Concern  = mongoose.models.Concern
Company  = mongoose.models.Company

module.exports = ->
  @World = require('../support/world').World

  @Before (next) ->
    mongoose.connection.db.dropDatabase next

  @Given /^the following Concern(?:s)? exist(?:s)?:$/, (table, next) ->
    concerns = (@toJSON(concern) for concern in table.hashes())

    do create = ->
      if concern = concerns.shift()
        company = concern.company
        delete concern.company
        Company.findOrCreate { domain: company.domain }, (err, company) ->
          concern.company = company.id
          Concern.create concern, create
      else
        next()

  @Given /^the following Company exists:$/, (table, next) ->
    companies = table.hashes()

    do create = =>
      if company = companies.shift()
        company = @Factory('Company', company)
        Company.create company, create
      else
        next()
