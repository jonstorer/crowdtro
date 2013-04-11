Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: LongActions loading state displays a spinner
    Given I am on the site
    Then I should see the new concern form
    When I enter "Too many concerns" in the textarea within the new concern form
    And I press "Add"
    Then I should see "Too many concerns" within the pending concerns list
