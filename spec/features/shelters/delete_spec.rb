require 'rails_helper'

describe "shelters" do
  it "can delete a shelter" do
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

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_link("Delete Shelter")

    click_link("Delete Shelter")

    expect(current_path).to eq("/shelters")

    expect(page).to have_no_content(shelter_1.name)
    expect(page).to have_content(shelter_2.name)
  end

  it "deletes all pets in shelter when deleted" do
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

    pet_1 = shelter_1.pets.create(name: "Buddy",
                          approximate_age: 6,
                          sex: "Male",
                          image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")
    pet_2 = shelter_2.pets.create(name: "Zula",
                         approximate_age: 4,
                         sex: "Female",
                         image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")
    pet_3 = shelter_1.pets.create(name: "King",
                       approximate_age: 5,
                       sex: "Male",
                       image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
                       shelter_id: 2)

    visit "/pets"
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_3.name)

    visit "/shelters"

    within("#shelter-#{shelter_1.id}") do
      click_link("Delete Shelter")
    end

    visit "/pets"
    expect(page).to have_no_content(pet_1.name)
    expect(page).to have_no_content(pet_3.name)
    expect(page).to have_content(pet_2.name)
  end

  it "deletes reviews upon deletion" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    review_1 = shelter_1.reviews.create(title: "Super Helpful",
                                        content: "Very patient staff, well trained pets for life, and overall very satisfied!",
                                        rating: 5,
                                        picture: "https://www.petmd.com/sites/default/files/CANS_dogsmiling_379727605.jpg")

    review_2 = shelter_1.reviews.create(title: "Need More Pets In My Life",
                                        rating: 4,
                                        content: "Definitely, quality over quantity, and I guess that's not necessarily a bad thing!")

    visit "/shelters"

    within("#shelter-#{shelter_1.id}") do
      click_link "Delete Shelter"
    end

    expect(Review.all).to eq([])
  end
end
