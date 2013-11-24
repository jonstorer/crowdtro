Feature: Concerns load
  In order for crowdtro to load quickly
  Incomplete concerns load automatically
  But complete concerns must be fetched manually

  Scenario: Concerns load correctly
    Given I am logged in as:
      | first_name | last_name | email              |
      | Steve      | Shin      | steve@crowdtap.com |
    And the following Concern exists:
      | content       | complete |
      | Such Football | false    |
      | So iPad Mini  | true     |
    When I am on the site
    Then I should see the "Such Football" concerns element within the pending concerns list
    But I should not see the "So iPad Mini" concerns element
    When I click the load link
    Then I should see the "So iPad Mini" concerns element within the complete concerns list
    But I should not see the load link
    And there should be 1 "Such Football" concerns element within the pending concerns list
