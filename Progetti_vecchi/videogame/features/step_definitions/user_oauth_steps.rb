Given (/^I am not logged in$/) do
    @before = User.count
    User.where(name: "John Doe").length.should == 0
end

Then (/^I should be logged in$/) do
    User.count.should == @before + 1
    User.where(name: "John Doe").length.should == 1
end
