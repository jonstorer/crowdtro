Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: LongActions loading state displays a spinner
    Given a "Too many concerns" Concern exists
    And I am on the site
    Then I should see "Too many concerns" within the pending concerns list
    When I check off "Too many concerns"
    Then I should not see "Too many concerns" within the pending concerns list
    But I should see "Too many concerns" within the complete concerns list
