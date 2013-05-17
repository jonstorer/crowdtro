Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Scenario: User adds concern
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And I am on the site
    Then I should see the new concern form
    When I enter "Too many concerns" in the textarea within the new concern form
    And I press "Add"
    Then I should see "Too many concerns" within the pending concerns list

  Scenario: User adds concern by pressing enter
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And I am on the site
    Then I should see the new concern form
    When I enter "Too many concerns" in the textarea within the new concern form
    And I key press "enter" in the textarea within the new concern form
    Then I should see "Too many concerns" within the pending concerns list
