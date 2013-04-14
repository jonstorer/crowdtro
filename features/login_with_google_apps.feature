Feature: User is required to log in with google apps
  In order to keep our concerns private
  A visitor must log in with google apps

  Scenario: Visitor must log in with google apps
    Given I am on the site
    Then I should not see the new concern form
    When I press "Google"
    Then I should see the new concern form
