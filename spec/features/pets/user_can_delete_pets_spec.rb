require 'rails_helper'

describe "as a visitor" do
  it "can delete a pet from it's individual page and remove it from the db" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    pet_1 = shelter_1.pets.create(name: "Buddy",
                                  approximate_age: 6,
                                  sex: "Male",
                                  image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")

    pet_2 = shelter_1.pets.create(name: "King",
                                  approximate_age: 5,
                                  sex: "Male",
                                  image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png")

    visit "/pets/#{pet_1.id}"

    click_link "Delete Pet"

    expect(current_path).to eq("/pets")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_no_content(pet_1.name)
    end
  end
