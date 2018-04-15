Feature: Create a game
  In order create a game
  As a registered, non banned user
  I want to insert a game into the database

  @omniauth_test_success
  Scenario: Creating a game
    Given I am on the homepage
    And I am logged in
    And I am not banned
    And A game named "ABC" doesn't exist
    When I press "Add new Game"
    And I fill in "name" with "ABC" in form "game"
    And I fill in "genre" with "TestGenre" in form "game"
    And I fill in "maker" with "TestMaker" in form "game"
    And I fill in "description" with "TestDescription" in form "game"
    And I attach the file at "spec/fixtures/images/game.jpg" to "Photo"
    And I click "Save"
    Then I should see "ABC"
