module.exports =
  # Helpers

  '^(.*) within (.*)$': (inner, outer, next) ->
    @selectorFor outer, (outerSelector) =>
      @selectorFor inner, (innerSelector) ->
        next "#{outerSelector} #{innerSelector}"

  # Dynamic Selectors

  '^the "([^"]+)" concerns (show|edit) element$': (value, type, next) =>
    Concern = require('mongoose').models.Concern
    Concern.findOne { content: value }, (err, concern) ->
      if err
        console.log err
        throw err
      next("#concern-#{concern.id} .#{type}-concern")

  '^the "([^"]+)" concerns element$': (value, next) =>
    Concern = require('mongoose').models.Concern
    Concern.findOne { content: value }, (err, concern) ->
      if err
        console.log err
        throw err
      next("#concern-#{concern.id}")

  '^the (.+) link$': (type, n) -> n ".#{type.replace(' ', '')}"

  # Static Selectors

  '^the pending concerns list$':   (n) -> n '.pending'
  '^the edit link$':               (n) -> n '.edit'
  '^the complete concerns list$':  (n) -> n '.complete'
  '^the new concern form$':        (n) -> n 'form#new-concern'
  '^the textarea$':                (n) -> n 'textarea'
  '^the page$':                    (n) -> n 'body'

  # Paths

  '^the site$':       (n) -> n '/'
  '^the homepage$':   (n) -> n '/'
  '^the login path$': (n) -> n '/login'

  # Fall through

  '^(.+)$': (selector, next) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    next selector
