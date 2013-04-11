Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: User deletes a concern
    Given the following Concern exists:
      | content |
      | So Many |
    Given I am on the site
    When I click the delete link within the "So Many" concerns element
    Then I should not see "So Many" within the pending concerns list
    And I should not see "So Many" within the complete concerns list
    When I am on the site
    Then I should not see "So Many" within the pending concerns list
    And I should not see "So Many" within the complete concerns list
