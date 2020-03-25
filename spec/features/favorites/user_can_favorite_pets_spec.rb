require 'rails_helper'

describe "as a user" do
  it "can favorite pets" do

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
                       adoption_status: "Adoptable",
                       favorited: false)

    visit "/pets/#{pet_1.id}"
    expect(page).to have_content("Favorites (0)")

    click_link("Favorite Pet")

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_content("#{pet_1.name} has been added to your favorites list.")
    expect(page).to have_content("Favorites (1)")
  end
end
