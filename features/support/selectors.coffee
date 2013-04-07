module.exports =
  # Helpers

  '^(.*) within (.*)$': (inner, outer) ->
    return "#{@selectorFor(outer)} #{@selectorFor(inner)}"

  # Static Selectors

  '^the current concerns list$':  '#current-concerns'
  '^the new concern form$':       'form#new-concern'
  '^the textarea$':               'textarea'

  # Paths

  'the site': '/'


  # Fall through

  '^(.+)$': (selector) ->
    console.log "\n\nNo selector was found for '#{selector}'"
    console.log "Please do not commit code that uses this into master\n"
    return selector
