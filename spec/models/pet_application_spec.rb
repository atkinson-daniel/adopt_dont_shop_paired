require 'rails_helper'

RSpec.describe PetApplication do
  describe "relationships" do
      it { should belong_to :pet }
      it { should belong_to :application }
  end

  describe "#pet_name" do
    it "can return name of pet in application" do
      shelter = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

      pet = shelter.pets.create(name: "Buddy",
                                approximate_age: 6,
                                sex: "Male",
                                image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                                adoption_status: "Adoptable")
      application = Application.create(name: "Test Name",
                                      address: "Test Address",
                                      city: "Test city",
                                      state: "Test State",
                                      zip: "Test Zip",
                                      phone_number: "Test Phone Number",
                                      description: "Test Description")

      pet_app = PetApplication.create(application_id: application.id, pet_id: pet.id)

      expect(pet_app.pet_name).to eq("Buddy")
    end
  end
end
