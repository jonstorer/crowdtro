Feature: User can add a concern
  In order to keep track of concerns during retro
  A user can add concerns to the concerns list

  Background:
    Given a "Too many concerns" Concern exists
    And I am on the site

  Scenario: User Marks a concern as done
    Then I should see "Too many concerns" within the pending concerns list
    When I click the complete link within the "Too many concerns" concerns element
    Then I should not see "Too many concerns" within the pending concerns list
    But I should see "Too many concerns" within the complete concerns list

  @wrongDocument @wip
  Scenario: User marks a concern as pending
    Given I click the complete link within the "Too many concerns" concerns element
    When I click the pending link within the "Too many concerns" concerns element
    Then I should see "Too many concerns" within the pending concerns list
    But I should not see "Too many concerns" within the complete concerns list
