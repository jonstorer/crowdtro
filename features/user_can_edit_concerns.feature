Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: LongActions loading state displays a spinner
    Given the following Concern exists:
      | content |
      | So Many |
    Given I am on the site
    Then the "So Many" concerns show element should be visible
    When I press the show icon within the edit icon within the "So Many" concerns show element
    Then the "So Many" concerns show element should be hidden
    Then the "So Many" concerns edit element should be visible
