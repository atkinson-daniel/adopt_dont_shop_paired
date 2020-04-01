require 'rails_helper'

RSpec.describe Application do
  describe "validations" do
    [:name, :address, :city, :state, :zip, :phone_number, :description].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
      it { should have_many :pet_applications }
  end

  describe "methods" do
    before(:each) do

      @shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      @pet_1 = @shelter_1.pets.create(name: "Buddy",
                                    approximate_age: 6,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                                    adoption_status: "Adoptable")
      @application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
      @application_2 = Application.create(name: "David Tran", address: "123 Fake St", city: "Castle Rock", state: "CO", zip: "80129", phone_number: "303-555-5555", description: "Aniamls Rock.")
      PetApplication.create(application: @application_1, pet: @pet_1)
      PetApplication.create(application: @application_2, pet: @pet_1)
    end
    describe "#applications_by_pet" do
      it "finds all the applications of a pet through params" do

        params = {pet_id: @pet_1.id}

        expect(Application.applications_by_pet(params)).to eq([@application_1, @application_2])
      end
    end
  end
end
