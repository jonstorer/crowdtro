Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: Concerns without votes should not show score
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And the following Concern exists:
      | content | score |
      | So Many | 0     |
    When I am on the site
    Then I should not see "+0" within the "So Many" concerns element

  Scenario: User can up vote a concern
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And the following Concern exists:
      | content |
      | So Many |
    When I am on the site
    And I click the up vote link within the "So Many" concerns element
    Then I should see "+1" within the "So Many" concerns element
