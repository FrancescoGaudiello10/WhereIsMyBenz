Feature: Delete an user
  In order delete an user
  As an admin
  I want to remove an user from the database

  @omniauth_test_success
  Scenario: Deleting an user
    Given a dummy user exists
    And I am logged in
    And I am admin
    And I am on the dummy user page
    When I press "Destroy User"
    Then I should not see "DummyUser"
