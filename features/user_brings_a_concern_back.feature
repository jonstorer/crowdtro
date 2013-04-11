Feature: User can bring a concern back from done
  In order to keep track of concerns during retro
  A user can move a concern from complete to current

  Scenario: A concern moved from complete to pending
    Given the following Concern exists:
      | content          | complete |
      | Unhealthy snacks | true     |
    And I am on the site
    Then I should see "Unhealthy snacks" within the complete concerns list
    When I click the pending link within the "Unhealthy snacks" concerns element
    Then I should not see "Unhealthy snacks" within the complete concerns list
    But I should see "Unhealthy snacks" within the pending concerns list
