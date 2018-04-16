Feature: Create a review
  In order write a review
  As a registered, non banned user
  I want to add a review for a game

  @omniauth_test_success
  Scenario: Reviewing a game
    Given I am logged in
    And I am not banned
    And I am on the test game page
    When I press "Add review"
    And I fill in "description" with "Very good game" in form "review"
    And I click "Create Review"
    Then I should see "John Doe"
