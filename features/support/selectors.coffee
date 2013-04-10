module.exports =
  # Helpers

  '^(.*) within (.*)$': (inner, outer, callback) ->
    string = "#{inner} within #{outer}"
    namedElements = [ ]
    while match = string.match(new RegExp('^(.*) within (.*)$'))
      namedElements.push match['2']
      string = match['1']

    namedElements.push string

    namedElements.each (element) =>
      @selectorFor(element, callback)




    #"#{@selectorFor(outer)} #{@selectorFor(inner)}"

  # Dynamic Selectors

  '^the "([^"]+)" concerns show element$': (value, callback) =>
    Concern = require('mongoose').models.Concern
    Concern.findOne { content: value }, (err, concern) ->
      throw err if err
      callback("#concern-#{concern.id}-show")

  # Static Selectors

  '^the current concerns list$':  '.pending'
  '^the edit icon$':              '.icon-edit'
  '^the old concerns list$':      '.complete'
  '^the new concern form$':       'form#new-concern'
  '^the textarea$':               'textarea'

  # Paths

  'the site': '/'

  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    selector
