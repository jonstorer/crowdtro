Feature: User is required to log in with google apps
  In order to keep our concerns private
  A visitor must log in with google apps

  @wip
  Scenario: Visitor must log in with google apps
    Given I am logged into google as:
      | first_name | last_name | email               |
      | Steven     | Phillips  | steven@crowdtap.com |
    And I am on the site
    Then I should not see the new concern form
    When I click "Google Apps"
    Then I should see the new concern form
