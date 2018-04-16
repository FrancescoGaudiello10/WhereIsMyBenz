Given(/^I am logged in$/) do
    visit games_path
    if (have_text("Sign in with Facebook"))
        click_link("Sign in with Facebook")
    end
    expect(page).to have_text("Welcome")
end

Given(/^I am not banned$/) do
    visit games_path
    expect(page).to have_text("Listing Games")
end

Given(/^I am admin$/) do
    visit games_path
    expect(page).to have_text("Administration Panel")
end

Given(/^I own the review or I am admin$/) do
    if (User.where(name: "John Doe").first.role == "Admin")
        step 'I am admin'
    else
        User.where(name: "John Doe").first.reviews.length.should == 1
    end
end

Given(/^I own the game or I am admin$/) do
    if (User.where(name: "John Doe").first.role == "Admin")
        step 'I am admin'
    else
        User.where(name: "John Doe").first.games.length.should == 1
    end
end

Given(/^I own the ad or I am admin$/) do
    if (User.where(name: "John Doe").first.role == "Admin")
        step 'I am admin'
    else
        User.where(name: "John Doe").first.ads.length.should == 1
    end
end
