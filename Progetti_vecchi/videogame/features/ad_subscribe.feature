Feature: Subscribe to an ad
  In order to subscribe to an ad
  As a registered, non banned user
  I want to add subscribe to an ad for a game

  @omniauth_test_success
  Scenario: Subscribing to an ad
    Given I am logged in
    And I am not banned
    And I am on the test ad page
    When I press "Sono interessato"
    And I am on the homepage
    And I press "Show responses list"
    Then I should see "John Doe"
