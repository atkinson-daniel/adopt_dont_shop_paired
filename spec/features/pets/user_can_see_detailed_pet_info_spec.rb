require 'rails_helper'

describe "as a visitor" do
  it "can view detailed pet info from id" do

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

    pet_2 = shelter_1.pets.create(name: "King",
                       approximate_age: 5,
                       sex: "Male",
                       image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
                       description: "His name might be King, but he'll treat you like royalty.",
                       adoption_status: "Pending")

    visit "/pets/#{ pet_1.id }"

    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.adoption_status)
    expect(page).to have_no_content(pet_2.name)

    expect(page).to have_no_link("Change to Adoptable")
    click_link("Change to Adoption Pending")

    expect(current_path).to eq("/pets/#{pet_1.id}")
    expect(page).to have_link("Change to Adoptable")
    expect(page).to have_no_link("Change to Adoption Pending")


  end
end
