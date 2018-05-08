Feature: Add station
  As a admin user
  So that I can give more info about a station
  I want to create a new station

  Scenario: Create insertion
    Given I am a registered admin user
    And I log in
    When I follow "Stazioni"
    And I follow "Aggiungi Stazione"
    And I fill in "Bandiera" with "ESSO"
    And I fill in "Nome" with "Mario Rossi"
    And I fill in "Indirizzo" with "Via Ariosto 22, Roma"
    And I fill in the following:
      | Benzina | 1.867 |
      | Gasolio | 1.456 |
      | GPL     | 0.555 |
    And I press "Crea Stazione"
    Then I should see "Stazioni"
    And I should see "ESSO"
