require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# Status
Given /^I am a registered user$/ do
    User.create!({:uid => 1, :email => "lollo@diag.uniroma1.it", :password => "123456", :password_confirmation => "123456", :admin => 0 })
end

Given /^I am a registered admin user$/ do
    User.create!({:uid => 1, :email => "lollo@diag.uniroma1.it", :password => "123456", :password_confirmation => "123456", :admin => 1 })
end

# Direction
Given /^(?:|I )am on (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
    visit path_to(page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
    first(:link, link).click
end

# Filling
When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
    fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
    fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
    fields.rows_hash.each do |name, value|
        When %{I fill in "#{name}" with "#{value}"}
    end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
    select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
    check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
    uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
    choose(field)
end

And(/^I press "([^"]*)"$/) do |button|
    click_button(button)
end

# Check
Then /^(?:|I )should be on (.+)$/ do |page_name|
    current_path = URI.parse(current_url).path
    if current_path.respond_to? :should
        expect(current_path).to be == path_to(page_name)
    else
        assert_equal path_to(page_name), current_path
    end
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
    if page.respond_to? :should
        expect(page).to have_content(text)
    else
        assert page.has_content?(text)
    end
end

# Action
When /^I log in$/ do
    steps %Q{
      Given I am on the login page
      When I fill in "Email" with "lollo@diag.uniroma1.it"
      And I fill in "Password" with "123456"
      And I press "Log in"
      Then I should be on the home page
      And I should see "Ricerca"
  }
end

When /^I create a new station$/ do
    steps %Q{
    Give I am on the home page
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
  }
end
