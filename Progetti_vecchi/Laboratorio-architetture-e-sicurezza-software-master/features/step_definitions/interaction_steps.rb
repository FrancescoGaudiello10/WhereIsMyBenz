When (/^I press "([^\"]*)"$/) do |text|
    click_link(text)
end

When (/^I click "([^\"]*)"$/) do |text|
    click_button(text)
end

When(/^I fill in "([^"]*)" with "([^"]*)" in form "([^"]*)"$/) do |arg1, arg2, arg3|
    fill_in ""+arg3+"["+arg1+"]", with: arg2
end

When (/^I attach the file at "([^\"]*)" to "([^\"]*)"$/) do |path, field|
  attach_file(field, Rails.root + path)
end

Then(/^I should see "([^"]*)"$/) do |arg1|
    expect(page).to have_text(arg1)
end

Then(/^I should not see "([^"]*)"$/) do |arg1|
    expect(page).not_to have_text(arg1)
end
