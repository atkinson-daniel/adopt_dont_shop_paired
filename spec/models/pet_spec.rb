require 'rails_helper'

describe Pet do
  describe "validations" do
    [:name, :approximate_age, :sex, :image].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:applications).through(:pet_applications)}
  end

  describe "#update_adoption_status" do
    it "should change adoption status" do
      shelter_1 = Shelter.create(name: "Dumb Friends League",
        address: "123 Fake Street",
        city:    "Castle Rock",
        state:   "CO",
        zip:     "80104")

      pet_1 = shelter_1.pets.create(name: "Buddy",
        approximate_age: 6,
        sex: "Male",
        image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
        description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
        adoption_status: "Pending")

      pet_2 = shelter_1.pets.create(name: "King",
        approximate_age: 5,
        sex: "Male",
        image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
        description: "His name might be King, but he'll treat you like royalty.",
        adoption_status: "Adoptable")

      application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
      application_2 = Application.create(name: "David Tran", address: "123 Fake St", city: "Castle Rock", state: "CO", zip: "80129", phone_number: "303-555-5555", description: "Aniamls Rock.")

      pet_app_1 = PetApplication.create(application: application_1, pet: pet_1, approved: true)
      pet_app_2 = PetApplication.create(application: application_1, pet: pet_2)
      pet_app_3 = PetApplication.create(application: application_2, pet: pet_1)

      params = {app_id: application_1.id}

      pet_1.update_adoption_status("Adoptable", false, params)

      pet_1.reload
      pet_app_1.reload

      expect(pet_1.adoption_status).to eq("Adoptable")
      expect(pet_app_1.approved).to eq(false)

      pet_2.update_adoption_status("Pending", true, params)

      pet_2.reload
      pet_app_2.reload

      expect(pet_2.adoption_status).to eq("Pending")
      expect(pet_app_2.approved).to eq(true)
    end
  end
end
