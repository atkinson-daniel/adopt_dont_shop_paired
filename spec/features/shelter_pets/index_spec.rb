require 'rails_helper'

describe "as a visitor" do
  it "can see pets with shelter id on the shelter show page" do

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

    pet_3 = Pet.create(name: "King",
                       approximate_age: 5,
                       sex: "Male",
                       image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
                       shelter_id: 2)

    visit "/shelters/#{shelter_1.id}/pets"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content(pet_2.name)
    expect(page).to have_css("img[src*='#{pet_2.image}']")
    expect(page).to have_no_content(pet_3.name)

    expect(page).to have_link("Update Pet", href: "/pets/#{pet_1.id}/edit")
    expect(page).to have_link("Update Pet", href: "/pets/#{pet_2.id}/edit")
    expect(page).to have_link("Delete Pet")

  end
end
