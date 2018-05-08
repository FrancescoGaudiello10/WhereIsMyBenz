Feature: Edit profile
  As a registered user
  So that I can change the info about me
  I want to edit my profile

  Scenario: Edit profile
    Given I am a registered user
    And I log in
    When I go to my profile page
    And I check "admin_checkbox"
    And I fill in "luogo_preferito" with "Via Ariosto 22, Roma"
    #And I select "Esso" from "stazione_preferita"
    #And I select "Benzina" from "carburante_preferito"
    And I fill in "litri_serbatoio" with "44"
    And I fill in "user[current_password]" with "123456"
    And I press "Aggiorna"
    Then I am on the home page
    And I should see "lollo@diag.uniroma1.it (admin)"