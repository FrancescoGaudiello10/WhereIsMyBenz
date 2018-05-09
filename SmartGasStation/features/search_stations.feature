Feature: Search stations
  As a user
  So that I can find the cheapest gas stations nearby
  I want to insert my location

  Scenario: Search for gas stations
    Given I am a registered user
    And I log in
    When I fill in "mySearchBar" with "Via Ariosto 22, Roma"
    And I fill in "myRadius" with "1"
    And I select "Benzina" from "myDropdown"
    And I press "myButton"
    Then I should see "impianto trovato"
