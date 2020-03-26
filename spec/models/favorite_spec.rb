require 'rails_helper'

describe Favorite do
  describe "#total_count" do
    it "can calculate the total number of favorited pets" do

      favorites = Favorite.new(["pet_1", "pet_2"])

      expect(favorites.total_count).to eq(2)
    end
  end

  describe "#add_pet" do
    it "can add a pet to the current session" do
      favorites = Favorite.new(["pet_1", "pet_2"])

      favorites.add_pet("pet_3")

      expect(favorites.total_count).to eq(3)
      expect(favorites.contents).to eq(["pet_1", "pet_2", "pet_3"])
    end
  end

  describe "#all_favorited_pets" do
    it "returns all favorited pets" do
      favorites = Favorite.new(["pet_1", "pet_2"])

      expect(favorites.all_favorited_pets).to eq(["pet_1", "pet_2"])
    end
  end
end
