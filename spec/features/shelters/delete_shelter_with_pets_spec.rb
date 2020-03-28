require 'rails_helper'

describe "shelter index" do
  it "can't delete a shelter if the shelter has a pet with a Pending adoption status" do
    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")
    shelter_2 = Shelter.create(name:    "Pawty Please",
                               address: "000 Another Fake St",
                               city:    "Denver",
                               state:   "CO",
                               zip:     "80204")

    shelter_1.pets.create(name: "Buddy",
                          approximate_age: 6,
                          sex: "Male",
                          image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                          adoption_status: "Pending")
    shelter_1.pets.create(name: "Zula",
                         approximate_age: 4,
                         sex: "Female",
                         image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

    visit "/shelters"

    within("#shelter-#{shelter_1.id}") do
      expect(page).to have_no_link("Delete Shelter")
    end

    within("#shelter-#{shelter_2.id}") do
      expect(page).to have_link("Delete Shelter")
    end
  end
end
