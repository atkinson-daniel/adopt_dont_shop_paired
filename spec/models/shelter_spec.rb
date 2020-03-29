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

  describe "methods" do
    describe "#destroy_associated" do
      it "deletes foreign keys associated with a shelter" do

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

        review_2 = shelter_1.reviews.create(title: "Need More Pets In My Life",
                                            rating: 4,
                                            content: "Definitely, quality over quantity, and I guess that's not necessarily a bad thing!")

        shelter_1.destroy_associated

        expect(shelter_1.pets).to eq([])
        expect(shelter_1.reviews).to eq([])
      end
    end

    describe "#average_rating" do
      it "calculates average rating from reviews" do
        shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                   address: "123 Fake Street",
                                   city:    "Castle Rock",
                                   state:   "CO",
                                   zip:     "80104")
        shelter_1.reviews.create(title: "Best Animal Shelter",
                                 rating: 5,
                                 content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.",
                                 picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
        shelter_1.reviews.create(title: "Found My Forever Friend",
                                 rating: 1,
                                 content: "Today I brought home Simba. Very excited for him to be apart of our family.",
                                 picture:"")

        expect(shelter_1.average_rating).to eq(3.0)

        shelter_1.reviews.create(title: "Found My Forever Friend",
                                 rating: 5,
                                 content: "Today I brought home Simba. Very excited for him to be apart of our family.",
                                 picture:"")

        expect(shelter_1.average_rating).to eq(3.7)
      end
    end

    describe "#count_of_pets" do
      it "counts number of pets associated with shelter" do
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

        expect(shelter_1.count_of_pets).to eq(2)

        shelter_1.pets.create(name: "Zula",
                              approximate_age: 4,
                              sex: "Female",
                              image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

        expect(shelter_1.count_of_pets).to eq(3)
      end
    end

    describe "#count_of_applications" do
      it "counts number of applications associated with shelter" do
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

        application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")

        application_2 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")

        PetApplication.create(application: application_1, pet: pet_1)
        PetApplication.create(application: application_2, pet: pet_1)

        expect(shelter_1.count_of_applications).to eq(2)

        application_3 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
        PetApplication.create(application: application_3, pet: pet_1)

        expect(shelter_1.count_of_applications).to eq(3)
      end
    end
  end
end
