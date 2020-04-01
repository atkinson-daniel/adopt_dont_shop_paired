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

  describe "#approved_pet_apps" do
    it "returns all pets with an approved application" do
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

      application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
      application_2 = Application.create(name: "David Tran", address: "72 Hallow St", city: "Castle Rock", state: "CO", zip: "80104", phone_number: "303-566-9242", description: "I'm eager to bring a new friend into my home.")

      pet_app_1 = PetApplication.create(application: application_1, pet: pet_1)
      pet_app_1.approve_application

      expect(Pet.approved_pet_apps).to eq([pet_1])

      pet_app_2 = PetApplication.create(application: application_2, pet: pet_2)
      pet_app_2.approve_application

      expect(Pet.approved_pet_apps).to eq([pet_1, pet_2])
    end
  end
end
