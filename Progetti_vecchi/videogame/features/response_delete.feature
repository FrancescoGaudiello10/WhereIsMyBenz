Feature: Delete a response
  In order to delete a response
  As a registered, non banned user
  I want to delete a response from my list

  @omniauth_test_success
  Scenario: Deleting a response
    Given I am logged in
    And I am not banned
    And I am on the test ad page
    When I press "Sono interessato"
    And I am on the homepage
    And I press "Show responses list"
    And I press "See details"
    And I press "Delete"
    Then I should not see "John Doe"
