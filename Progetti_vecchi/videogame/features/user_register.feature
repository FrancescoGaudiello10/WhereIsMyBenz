Feature: Register User via Facebook
  In order to sign up/ log in
  As a unregistered visitor
  I want to sign up via Facebook

  @omniauth_test_success
  Scenario: Logging in
    Given I am not logged in
    And I am on the homepage
    When I press "Sign in with Facebook"
    Then I should be logged in
