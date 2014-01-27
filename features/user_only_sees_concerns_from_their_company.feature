Feature: User only sees concerns from their company
  In order to keep track of concerns during retro
  A user can work with on the concerns list

  Scenario: User sees concerns from their company
    Given the following Concern exists:
      | content   | company                      |
      | So Many   | { "domain": "crowdtap.com" } |
      | So Little | { "domain": "shakelaw.com" } |
    And I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    When I am on the site
    Then I should see "So Many" within the page
    But I should not see "So Little" within the page
    When I click "Logout"
    And I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shon      | steve@shakelaw.com |
    And I am on the site
    Then I should see "So Little" within the page
    But I should not see "So Many" within the page
