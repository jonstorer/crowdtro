Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Background:
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |

  Scenario: User Marks a concern as done
    Given the following Concern exists:
      | content           | company                      |
      | Too many concerns | { "domain": "crowdtap.com" } |
    And I am on the site
    Then I should see "Too many concerns" within the pending concerns list
    When I click the complete link within the "Too many concerns" concerns element
    Then I should not see "Too many concerns" within the pending concerns list
    But I should see "Too many concerns" within the complete concerns list

  Scenario: User marks a concern as pending
    Given the following Concern exists:
      | content | complete | company                      |
      | So Many | true     | { "domain": "crowdtap.com" } |
    And I am on the site
    When I click the pending link within the "So Many" concerns element
    Then I should see "So Many" within the pending concerns list
    But I should not see "So Many" within the complete concerns list
