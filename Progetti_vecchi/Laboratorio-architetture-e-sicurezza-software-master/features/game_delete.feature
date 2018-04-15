Feature: Delete a game
  In order delete a game
  As a non banned creator or admin
  I want to delete a game into the database

  @omniauth_test_success
  Scenario: Deleting a game
    Given I am logged in
    And I am not banned
    And I am on the test game page
    And I own the game or I am admin
    And I am on the test game page
    When I press "Delete"
    Then I should see "Game 'TestGame' removed"
