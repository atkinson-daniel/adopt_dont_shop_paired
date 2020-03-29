require 'rails_helper'

describe "shelter page" do
  it "can display location information" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")
    review_1 = shelter_1.reviews.create(title: "Best Animal Shelter",
                                        rating: 5,
                                        content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.",
                                        picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
    review_2 = shelter_1.reviews.create(title: "Found My Forever Friend",
                                        rating: 4,
                                        content: "Today I brought home Simba. Very excited for him to be apart of our family.",
                                        picture:"")


    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.address)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.state)
    expect(page).to have_content(shelter_1.zip)
    expect(page).to have_link("Shelter's Pets")

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_css("img[src*='#{review_1.picture}']")

    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)

    expect(page).to have_link("Add New Review")
  end

  it "shows detailed info about count of pets, average rating, number of applications" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")
    review_1 = shelter_1.reviews.create(title: "Best Animal Shelter",
                                        rating: 5,
                                        content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.",
                                        picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
    review_2 = shelter_1.reviews.create(title: "Found My Forever Friend",
                                        rating: 3,
                                        content: "Today I brought home Simba. Very excited for him to be apart of our family.",
                                        picture:"")
    pet_1 = shelter_1.pets.create(name: "Buddy",
                                  approximate_age: 6,
                                  sex: "Male",
                                  image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*")
    pet_2 = shelter_1.pets.create(name: "Zula",
                                  approximate_age: 4,
                                  sex: "Female",
                                  image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg")

    application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
    application_3 = Application.create(name: "Aubree Smith", address: "9600 Shadow Ln", city: "Denver", state: "CO", zip: "80204", phone_number: "303-960-0240", description: "I love animals. Looking to add another to my family of two dogs, one cat, and one turtle.")

    PetApplication.create(application: application_1, pet: pet_1)
    PetApplication.create(application: application_3, pet: pet_2)

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_content("Shelter's Pets (2)")
    expect(page).to have_content("Number of Applications: 2")
    expect(page).to have_content("Average Review Rating: 4.0")

  end
end
