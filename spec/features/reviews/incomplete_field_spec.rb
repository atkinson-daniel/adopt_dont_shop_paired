require 'rails_helper'

describe "edit reviews form" do
  it "errors when a field is left empty" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    review_1 = shelter_1.reviews.create(title: "Super Helpful",
                                        content: "Very patient staff, well trained pets for life, and overall very satisfied!",
                                        rating: 5,
                                        picture: "https://www.petmd.com/sites/default/files/CANS_dogsmiling_379727605.jpg")

    visit "/shelters/#{shelter_1.id}"

    find("[href='/shelters/#{shelter_1.id}/reviews/#{review_1.id}/edit']").click
    fill_in :title, with: ""
    fill_in :content, with: "Test Content"
    fill_in :rating, with: 1

    click_on "Save Review"

    expect(page).to have_content("Unable to save review: Title can't be blank.")
    expect(page).to have_button("Save Review")

  end
end
