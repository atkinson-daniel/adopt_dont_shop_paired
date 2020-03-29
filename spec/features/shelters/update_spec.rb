require 'rails_helper'

describe "shelters page" do
  it "can update shelter info" do
    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    visit "/shelters/#{shelter_1.id}"

    expect(page).to have_no_content("Update Information")
    expect(page).to have_content(shelter_1.name)
    expect(page).to have_content(shelter_1.city)
    expect(page).to have_content(shelter_1.zip)
    expect(page).to have_link("Update Shelter")

    click_link("Update Shelter")

    expect(current_path).to eq("/shelters/#{shelter_1.id}/edit")
    expect(page).to have_content("Update Information")
    expect(page).to have_button("Save")
    fill_in :name, with: "New Shelter"
    fill_in :city, with: "New City"
    fill_in :address, with: "New Address"
    fill_in :state, with: "New State"
    fill_in :zip, with: "80204"

    click_button("Save")

    expect(current_path).to eq("/shelters/#{shelter_1.id}")
    expect(page).to have_no_content("Dumb Friends League")
    expect(page).to have_content("New Shelter")
    expect(page).to have_no_content("Castle Rock")
    expect(page).to have_content("New City")
  end

  it "can't update without necessary info" do
    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    visit "/shelters/#{shelter_1.id}"

    click_link("Update Shelter")

    fill_in :name, with: ""
    fill_in :address, with: "New Address"
    fill_in :state, with: "New State"
    fill_in :zip, with: "80204"

    click_button("Save")

    expect(page).to have_content("Unable to update shelter: Required fields are empty.")
  end
end
