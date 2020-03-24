require 'rails_helper'

RSpec.describe "When a visitor clicks Add New Review from shelter's show page", type: :feature do
  it "can fill out a form and add a new review" do
    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    visit "/shelters/#{shelter_1.id}"
    click_link("Add New Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    expect(page).to have_content("Add New Review")
    expect(page).to have_button("Submit Review")
    fill_in :title, with: "Found My Forever Friend"
    fill_in :rating, with: 4
    fill_in :content, with: "Today I brought home Simba. Very excited for him to be apart of our family."
    click_button("Submit Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Found My Forever Friend")
    expect(page).to have_content(4)
    expect(page).to have_content("Today I brought home Simba. Very excited for him to be apart of our family.")
    expect(page).to have_css("img[src*='']")


    visit "/shelters/#{shelter_1.id}"
    click_link("Add New Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/reviews/new")
    expect(page).to have_content("Add New Review")
    expect(page).to have_button("Submit Review")
    fill_in :title, with: "Best Animal Shelter"
    fill_in :rating, with: 5
    fill_in :content, with: "I adopted Brownie and she was well trained. The staff are friendly and helpful."
    fill_in :picture, with: "https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg"
    click_button("Submit Review")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content("Best Animal Shelter")
    expect(page).to have_content("5")
    expect(page).to have_content("I adopted Brownie and she was well trained. The staff are friendly and helpful.")
    expect(page).to have_css("img[src*='https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg']")

  end
  it 'cannot create review without title, rating, or content' do
    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    visit "/shelters/#{shelter_1.id}"
    click_link("Add New Review")
    click_button("Submit Review")

    expect(page).to have_content("Review not created. Title, rating, and content are required.")
    expect(page).to have_button('Submit Review')
  end
end
