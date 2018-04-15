Feature: Edit a review
  In order edit a review
  As non banned creator or admin
  I want to edit a review for a game

  @omniauth_test_success
  Scenario: Editing a review
    Given I am logged in
    And I am not banned
    And I am on the test review page
    And I own the review or I am admin
    And I am on the test review page
    When I press "Edit"
    And I fill in "description" with "review_edited" in form "review"
    And I click "Save Changes"
    And I press "Read more"
    Then I should see "review_edited"
