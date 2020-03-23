require 'rails_helper'

describe "as a visitor" do
  it "can delete pets from a link from the shelter pets index" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    pet_1 = shelter_1.pets.create(name: "Buddy",
                                  approximate_age: 6,
                                  sex: "Male",
                                  image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")
    pet_2 = shelter_1.pets.create(name: "Zula",
                                  approximate_age: 4,
                                  sex: "Female",
                                  image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)

    find("a[href='/shelters/#{shelter_1.id}/pets/#{pet_1.id}']").click

    expect(current_path).to eq("/shelters/#{shelter_1.id}/pets")
    expect(page).to have_no_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
  end
end
