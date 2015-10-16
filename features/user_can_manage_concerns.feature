# Feature: User can manage concerns
  # In order to keep track of concerns during retro
  # A user can work with on the concerns list

  # Background:
    # Given I am logged in as:
      # | first_name | last_name | email              |
      # | Steve      | Shin      | steve@crowdtap.com |
    # And the following Concern exists:
      # | content |
      # | So Many |
    # When I am on the site

  # Scenario: User adds concern
    # Then I should see the new concern form
    # When I enter "Too many concerns" in the textarea within the new concern form
    # And I press "Add"
    # Then I should see "Too many concerns" within the pending concerns list

  # Scenario: User edits an existing concern
    # Then I should see the "So Many" concerns element within the pending concerns list
    # And the "So Many" concerns show element should be visible
    # When I click the edit link within the "So Many" concerns element
    # Then the "So Many" concerns show element should be hidden
    # And the "So Many" concerns edit element should be visible
    # When I enter "Too Many" in the textarea within the "So Many" concerns element
    # And I click the cancel link within the "So Many" concerns element
    # Then the "So Many" concerns edit element should be hidden
    # And the "So Many" concerns show element should be visible
    # And I should see "So Many" within the textarea within the "So Many" concerns element
    # When I click the edit link within the "So Many" concerns element
    # And I enter "Not enough conerns" in the textarea within the "So Many" concerns element
    # And I press "Save" within the "So Many" concerns element
    # Then I should see "Not enough conerns" within the pending concerns list
    # When I click the edit link within the "Not enough conerns" concerns element
    # Then I should see "Not enough conerns" within the textarea within the "Not enough conerns" concerns element
