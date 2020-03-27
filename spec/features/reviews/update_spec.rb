require 'rails_helper'

describe "as a visitor" do
  it "can edit a review" do

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

  visit "/shelters/#{shelter_1.id}"
  expect(page).to have_content(review_1.title)
  expect(page).to have_content(review_2.title)
  expect(page).to have_content(review_1.content)
  expect(page).to have_content(review_2.content)

  find("[href='/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit']").click

  fill_in :title, with: "Test Title"
  fill_in :content, with: "Test Content"
  fill_in :rating, with: 1
  fill_in :picture, with: "https://images.fineartamerica.com/images/artworkimages/mediumlarge/1/cute-small-happy-dog-tilting-head-looking-forward-susan-schmitz.jpg"

  click_button("Save Review")

  expect(current_path).to eq("/shelters/#{shelter_1.id}")

  expect(page).to have_content(review_2.title)
  expect(page).to have_no_content("Super Helpful")
  expect(page).to have_no_content(review_1.content)
  expect(page).to have_content("Test Title")
  expect(page).to have_content("Test Content")
  expect(page).to have_content(1)

  end
end
