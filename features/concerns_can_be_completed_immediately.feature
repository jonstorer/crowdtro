Feature: User can complete a concern immediately
  In order to keep track of concerns during retro
  A user can complete concerns immediately

  Scenario: Concerns can be completed immediately
    Given I am on the site
    When I enter "Too many concerns" in the textarea within the new concern form
    And I press "Add"
    Then I should see "Too many concerns" within the pending concerns list
    When I click the complete link within the "Too many concerns" concerns element
    Then I should not see "Too many concerns" within the pending concerns list
    But I should see "Too many concerns" within the complete concerns list
    When I reload the page
    Then I should not see "Too many concerns" within the pending concerns list
    But I should see "Too many concerns" within the complete concerns list
