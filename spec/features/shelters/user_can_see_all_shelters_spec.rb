require 'rails_helper'

describe "shelters index page" do
  it "can display all shelters" do
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
    visit "/shelters"

    expect(page).to have_content(shelter_1.name)
    expect(page).to have_link("Dumb Friends League")
    expect(page).to have_content(shelter_2.name)
    expect(page).to have_link("Pawty Please")
    expect(page).to have_link("New Shelter", href:"shelters/new")

    expect(page).to have_link("Update Shelter", href: "/shelters/#{shelter_1.id}/edit")
    expect(page).to have_link("Update Shelter", href: "/shelters/#{shelter_2.id}/edit")
    expect(page).to have_link("Delete Shelter")
  end
end
