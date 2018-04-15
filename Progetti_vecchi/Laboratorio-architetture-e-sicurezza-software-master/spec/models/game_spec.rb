require 'spec_helper'

RSpec.describe Game, :type => :model do

    it "is valid" do
        expect(FactoryGirl.build(:game)).to be_valid
    end
    it "is invalid without a name" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.name = nil
        expect(@invalid_game.save).to eq(false)
    end
    it "is invalid without a description" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.description = nil
        expect(@invalid_game.save).to eq(false)
    end
    it "is invalid without a genre" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.genre = nil
        expect(@invalid_game.save).to eq(false)
    end
    it "is invalid if pegi not in range" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.pegi = '20'
        expect(@invalid_game.save).to eq(false)
    end
    it "is invalid without a maker" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.maker = nil
        expect(@invalid_game.save).to eq(false)
    end
    it "is invalid without a year" do
        @invalid_game = FactoryGirl.build(:game)
        @invalid_game.year = nil
        expect(@invalid_game.save).to eq(false)
    end
    it "has unique name" do
        FactoryGirl.create(:game)
        expect(FactoryGirl.build(:game)).not_to be_valid
    end
end
