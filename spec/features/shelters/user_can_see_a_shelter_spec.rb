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
    expect(page).to have_link("Our Shelters")

    expect(page).to have_content(review_1.title)
    expect(page).to have_content(review_1.rating)
    expect(page).to have_content(review_1.content)
    expect(page).to have_css("img[src*='#{review_1.picture}']")

    expect(page).to have_content(review_2.title)
    expect(page).to have_content(review_2.rating)
    expect(page).to have_content(review_2.content)

    expect(page).to have_link("Add New Review")
  end
end
