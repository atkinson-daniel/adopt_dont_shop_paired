require 'rails_helper'

describe "as a visitor" do
  it "can delete a review from the shelter's show page" do

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

    find("a[href='/shelters/#{shelter_1.id}/reviews/#{review_1.id}']").click

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_content(review_2.title)
    expect(page).to have_no_content(review_1.title)
    expect(page).to have_content(review_2.content)
    expect(page).to have_no_content(review_1.content)

  end
end
