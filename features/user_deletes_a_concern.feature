# Feature: User can add a concern
  # In order to keep track of concerns during retro
  # A user can add concerns to the concerns list

  # Scenario: User deletes a concern
    # Given the following Concern exists:
      # | content |
      # | So Many |
    # And I am logged in as:
      # | first_name | last_name | email              |
      # | Steve      | Shin      | steve@crowdtap.com |
    # And I am on the site
    # When I click the delete link within the "So Many" concerns element
    # Then I should not see "So Many" within the pending concerns list
    # And I should not see "So Many" within the complete concerns list
    # When I reload the page
    # Then I should not see "So Many" within the pending concerns list
    # And I should not see "So Many" within the complete concerns list
