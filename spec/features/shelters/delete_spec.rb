require 'rails_helper'

describe "shelters page" do
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
end
