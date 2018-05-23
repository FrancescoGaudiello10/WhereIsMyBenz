Feature: Station comment
 As a user
 So that I can give an opinion about a station
 I want to add a comment

 Scenario: Add a comment
   Given I am a registered user
   And there's another user
   When he logs in
   And he creates an insertion "Casa grande"
   And he logs out
   When I log in
   When I go to the last insertion page
   And I follow "Scrivi una recensione"
   And I fill in "review[title]" with "Molto bella"
   And I fill in "review[body]" with "Ne vale la pena"
   And I select "5" from "review_valutation"
   And I press "Invia recensione"
   Then I should see "Molto bella"
   And I should see "Ne vale la pena"
   And I should see "5"
