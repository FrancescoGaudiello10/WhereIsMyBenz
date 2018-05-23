Feature: Station comment
  As a user
  So that I can give an opinion about a station
  I want to add a comment

  Scenario: Add a comment
    Given I am a registered admin user
    When I log in
    And I create a new station
    And I go to the station details page
    And I fill in "comment[title]" with "Molto bella"
    And I fill in "comment[body]" with "Ne vale la pena"
    And I press "Crea recensione"
    Then I should see "Molto bella"
    And I should see "Ne vale la pena"
