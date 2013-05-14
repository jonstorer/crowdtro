Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Background:
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |

  Scenario: Concerns without votes should not show score
    Given the following Concerns exist:
      | content |
      | So Many |
    When I am on the site
    Then I should not see "+0" within the "So Many" concerns element

  @thisone
  Scenario: User can up vote a concern
    Given the following Concern exists:
      | content | score |
      | So Many | 0     |
      | So Few  | 12    |
    When I am on the site
    Then I should see "So Many" within the 1st concern within the pending concerns list
    And I should see "So Few" within the 2nd concern within the pending concerns list
    And I click the up vote link within the "So Many" concerns element
    Then I should see "+1" within the "So Many" concerns element
    And I should see "So Many" within the 1st concern within the pending concerns list
    And I should see "So Few" within the 2nd concern within the pending concerns list

  Scenario: User can down vote a concern that has a score above 0
    Given the following Concern exists:
      | content | score |
      | So Many | 4     |
    When I am on the site
    Then I should see "+4" within the "So Many" concerns element
    When I click the down vote link within the "So Many" concerns element
    Then I should see "+3" within the "So Many" concerns element

  Scenario: User cannot down vote a concern below 0
    Given the following Concern exists:
      | content | score |
      | So Many | 0     |
    When I am on the site
    Then I should not see "+0" within the "So Many" concerns element
    When I click the down vote link within the "So Many" concerns element
    Then I should not see "-1" within the "So Many" concerns element
