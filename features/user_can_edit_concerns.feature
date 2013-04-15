Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: LongActions loading state displays a spinner
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And the following Concern exists:
      | content |
      | So Many |
    Given I am on the site
    Then the "So Many" concerns show element should be visible
    When I click the edit link within the "So Many" concerns element
    Then the "So Many" concerns show element should be hidden
    Then the "So Many" concerns edit element should be visible
