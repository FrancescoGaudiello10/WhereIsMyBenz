Feature: User can create a new account
  As a visitor
  So that the system remembers me
  I want to create a new account

Scenario: Create a new account
  Given I am on the sign up page
  When I fill in "Email" with "lollo@gmail.com"
  And I fill in "Password" with "lollo1"
  And I fill in "user[password_confirmation]" with "lollo1"
  And I press "Sign Up"
  Then I should be on the profile page
  And I should see "Profilo"
  Then I should see "lollo@gmail.com"

Scenario: Can't create an account (email required)
  Given I am on the sign up page
  And I fill in "Password" with "lollo1"
  And I fill in "user[password_confirmation]" with "lollo1"
  And I press "Sign up"
  Then I should see "Email can't be blank"