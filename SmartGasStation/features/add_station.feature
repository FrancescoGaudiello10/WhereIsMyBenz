Feature: Add station
  As an admin user
  So that I can give more info about a station
  I want to create a new station

  Scenario: Create new station
    Given I am a registered admin user
    And I log in
    When I follow "Stazioni"
    And I follow "Aggiungi stazione"
    And I fill in "Bandiera" with "ESSO"
    And I fill in "Nome" with "Mario Rossi"
    And I fill in "Indirizzo" with "Via Ariosto 22, Roma"
    And I fill in "Benzina" with "1.678"
    And I fill in "Diesel" with "1.489"
    And I fill in "GPL" with "0.600"
    And I press "Crea Stazione"
    Then I should see "Stazioni"
    And I should see "ESSO"
