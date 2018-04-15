Given(/^a dummy user exists$/) do
    @dummy = User.from_omniauth(OmniAuth::AuthHash.new({
        "provider"  => "facebook",
        "uid"       => '67890',
        "info" => {
            "email" => "email@dummy.com",
            "first_name" => "Dummy",
            "last_name"  => "User",
            "name"       => "DummyUser"
        },
        "credentials" => {
            "token" => "DUMMYTOKEN",
            "expires_at" => 12345,
            "expires" => true
        }
    }))
    User.where(name: "DummyUser").length.should == 1
end

Given(/^A game named "([^"]*)" doesn't exist$/) do |arg1|
    Game.where(name: arg1).length.should == 0
end

Given(/^A game named "([^"]*)" exists$/) do |arg1|
    step 'I am on the homepage'
    step 'I am logged in'
    step 'I am not banned'
    step 'A game named "ABC" doesn\'t exist'
    step 'I press "Add new Game"'
    step 'I fill in "name" with "'+arg1+'" in form "game"'
    step 'I fill in "genre" with "TestGenre" in form "game"'
    step 'I fill in "maker" with "TestMaker" in form "game"'
    step 'I fill in "description" with "TestDescription" in form "game"'
    step 'I attach the file at "spec/fixtures/images/game.jpg" to "Photo"'
    step 'I click "Save"'
    step 'I should see "'+arg1+'"'
end
