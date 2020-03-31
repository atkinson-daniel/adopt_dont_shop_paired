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

  it "has a section of the top 3 highest rated shelters" do
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
    shelter_3 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")
    shelter_4 = Shelter.create(name:    "Pawty Please",
                               address: "000 Another Fake St",
                               city:    "Denver",
                               state:   "CO",
                               zip:     "80204")
    shelter_5 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")
    shelter_6 = Shelter.create(name:    "Pawty Please",
                               address: "000 Another Fake St",
                               city:    "Denver",
                               state:   "CO",
                               zip:     "80204")

    shelter_1.reviews.create(title: "Best Animal Shelter", rating: 2, content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.", picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
    shelter_3.reviews.create(title: "Best Animal Shelter", rating: 5, content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.", picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
    shelter_4.reviews.create(title: "Best Animal Shelter", rating: 3, content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.", picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
    shelter_6.reviews.create(title: "Best Animal Shelter", rating: 4, content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.", picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")

    visit "/shelters"
    
    within(".top-rated-shelters") do
      expect(page).to have_content(shelter_3.name)
      expect(page).to have_content(shelter_4.name)
      expect(page).to have_content(shelter_6.name)
    end
  end
end
