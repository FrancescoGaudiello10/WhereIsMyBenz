Feature: Create an ad
  In order to create an ad
  As a registered, non banned user
  I want to add an ad to a game

  @omniauth_test_success
  Scenario: Creating an ad
    Given I am logged in
    And I am not banned
    And I am on the test game page
    When I press "Add ad"
    And I fill in "location" with "Capital City" in form "ad"
    And I fill in "description" with "description_of_ad" in form "ad"
    And I fill in "delivery" with "delivery_mode" in form "ad"
    And I click "Create Ad"
    Then I should see "John Doe"
