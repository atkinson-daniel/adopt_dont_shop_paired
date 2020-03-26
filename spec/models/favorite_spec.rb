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

  describe "#delete_pet" do
    it "can delete a single pet" do
      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      pet_1 = shelter_1.pets.create(name: "Buddy",
                                    approximate_age: 6,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                                    adoption_status: "Adoptable")

      pet_2 = shelter_1.pets.create(name: "Test_Dog_1",
                                    approximate_age: 2,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Test Description",
                                    adoption_status: "Adoptable")
      favorites = Favorite.new([])
      favorites.add_pet(pet_1)
      favorites.add_pet(pet_2)

      favorites.delete_pet("#{pet_1.id}")

      expect(favorites.total_count).to eq(1)
      expect(favorites.contents).to eq([pet_2])
      expect(favorites.contents).to_not eq([pet_1])
    end
  end

  describe "#contains?" do
    it "return true or false if pet is within favorites" do
      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      pet_1 = shelter_1.pets.create(name: "Buddy",
                                    approximate_age: 6,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                                    adoption_status: "Adoptable")

      pet_2 = shelter_1.pets.create(name: "Test_Dog_1",
                                    approximate_age: 2,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Test Description",
                                    adoption_status: "Adoptable")
      favorites = Favorite.new([])
      favorites.add_pet(pet_1)

      expect(favorites.contains?(pet_1.id)).to eq(true)
      expect(favorites.contains?(pet_2.id)).to eq(false)
    end
  end
end
