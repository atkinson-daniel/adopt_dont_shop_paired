require 'rails_helper'

describe "as a visitor" do
  it "can see all pets favorited" do
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

    pet_3 = shelter_1.pets.create(name: "Test_Dog_2",
                                  approximate_age: 4,
                                  sex: "Female",
                                  image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRATvV2mL0wWqhpNXmsZtbsT4Zi8ElvfrE52Wvifx2C6N4P-M2S",
                                  description: "Test Description",
                                  adoption_status: "Pending")

    visit "/pets/#{pet_1.id}"
    click_on("Favorite Pet")

    visit "/pets/#{pet_2.id}"
    click_on("Favorite Pet")

    visit "/pets"
    expect(page).to have_no_content("Favorited Pets")
    click_on("Favorites (2)")

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Favorited Pets")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_no_content(pet_3.name)

    click_on("Remove All Favorites")

    expect(current_path).to eq("/favorites")
    expect(page).to have_no_content(pet_1.name)
    expect(page).to have_no_content(pet_2.name)
    expect(page).to have_no_content(pet_3.name)
    expect(page).to have_content("Favorites (0)")

  end
end
