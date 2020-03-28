require 'rails_helper'

describe Shelter do
  describe "validations" do
    [:name, :address, :city, :state, :zip].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
    it { should have_many :pets }
  end

  describe "any_pending_pets?" do
    it "should return true if any pets' adoption_status == 'Pending'" do
      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      shelter_1.pets.create(name: "Buddy",
                            approximate_age: 6,
                            sex: "Male",
                            image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                            adoption_status: "Pending")
      shelter_1.pets.create(name: "Zula",
                           approximate_age: 4,
                           sex: "Female",
                           image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

      expect(shelter_1.any_pending_pets?).to eq(true)
    end

    it "should return false if any pets' adoption_status == 'Adoptable'" do
      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      shelter_1.pets.create(name: "Buddy",
                            approximate_age: 6,
                            sex: "Male",
                            image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")
      shelter_1.pets.create(name: "Zula",
                           approximate_age: 4,
                           sex: "Female",
                           image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

      expect(shelter_1.any_pending_pets?).to eq(false)
    end
  end

  describe "#destroy_pets" do
    it "deletes pets associated with a shelter" do

      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      shelter_1.pets.create(name: "Buddy",
                            approximate_age: 6,
                            sex: "Male",
                            image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")

      shelter_1.pets.create(name: "Zula",
                            approximate_age: 4,
                            sex: "Female",
                            image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

      shelter_1.destroy_pets

      expect(shelter_1.pets).to eq([])
    end
  end
end
