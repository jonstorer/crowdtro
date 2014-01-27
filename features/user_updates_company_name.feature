Feature: Edit company name
  In order to customize the company a bit
  A user should be able to change the company's name

  Scenario: User changes the company name
    Given the following Company exists:
      | name | domain               |
      | null | foosball.example.org |
    Given I am logged in as:
      | email                      |
      | steve@foosball.example.org |
    When I am on the site
    Then I should see "foosball.example.org" within the header
    And the edit company form should be hidden
    When I click "foosball.example.org"
    Then the edit company form should be visible
    When I enter "Foosball Pros" in the company name field
    And I key press "enter" in the company name field
    Then I should see "Foosball Pros" within the header
    But I should not see "foosball.example.org" within the header
