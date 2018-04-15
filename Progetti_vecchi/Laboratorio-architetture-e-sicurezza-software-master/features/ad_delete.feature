Feature: Delete an ad
  In order to delete an ad
  As a non banned creator or admin
  I want to delete an ad from a game

  @omniauth_test_success
  Scenario: Deleting an ad
    Given I am logged in
    And I am not banned
    And I am on the test ad page
    And I own the ad or I am admin
    And I am on the test ad page
    When I press "Delete"
    Then I should not see "John Doe"
