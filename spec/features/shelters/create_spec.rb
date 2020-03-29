require 'rails_helper'

describe "shelters new page" do
  it "can ask for information, return to index, and post the new shelter" do

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

    visit "/shelters/new"

    expect(page).to have_text("Name")
    expect(page).to have_text("Address")
    expect(page).to have_text("City")
    expect(page).to have_text("State")
    expect(page).to have_text("Zip")
    expect(page).to have_button("Create Shelter")
    expect(page).to have_field(:name, :type=>"text")
    expect(page).to have_field(:address, :type=>"text")
    expect(page).to have_field(:city, :type=>"text")
    expect(page).to have_field(:state, :type=>"text")
    expect(page).to have_field(:zip, :type=>"number")

    fill_in :name, with: "Test Shelter"
    fill_in :address, with: "Test Address"
    fill_in :city, with: "Test City"
    fill_in :state, with: "Test State"
    fill_in :zip, with: "Test Zip"

    click_button("Create Shelter")

    expect(current_path).to eq("/shelters")
    expect(page).to have_link(shelter_1.name)
    expect(page).to have_link(shelter_2.name)
    expect(page).to have_link("Test Shelter")
  end

  it "can't create a shelter without necessary info" do
    visit "/shelters/new"

    fill_in :name, with: "Test Shelter"
    fill_in :address, with: "Test Address"
    fill_in :city, with: "Test City"
    fill_in :state, with: "Test State"

    click_button("Create Shelter")

    expect(page).to have_content("Unable to create shelter: Required fields are empty.")

  end
end
