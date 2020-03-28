require 'rails_helper'

RSpec.describe "as a user I can visit" do
  before(:each) do
    @shelter_1 = Shelter.create(name:    "Dumb Friends League",
      address: "123 Fake Street",
      city:    "Castle Rock",
      state:   "CO",
      zip:     "80104")

    @pet_1 = @shelter_1.pets.create(name: "Buddy",
      approximate_age: 6,
      sex: "Male",
      image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
      description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
      adoption_status: "Adoptable")

    @pet_2 = @shelter_1.pets.create(name: "Test_Dog_1",
      approximate_age: 2,
      sex: "Male",
      image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
      description: "Test Description",
        adoption_status: "Adoptable")

    @pet_3 = @shelter_1.pets.create(name: "Test_Dog_2",
      approximate_age: 4,
      sex: "Female",
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRATvV2mL0wWqhpNXmsZtbsT4Zi8ElvfrE52Wvifx2C6N4P-M2S",
      description: "Test Description",
      adoption_status: "Pending")

    visit "/pets/#{@pet_1.id}"
    click_link('Favorite Pet')
    visit "/pets/#{@pet_2.id}"
    click_link('Favorite Pet')
  end

  it "the favorites index page and can unfavorite a favorited pet" do
    visit '/favorites'
    expect(page).to have_content('Favorites (2)')
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)

    within("#favorite-pet-#{@pet_1.id}") do
      click_link('Remove from Favorites')
    end

    expect(current_path).to eq('/favorites')
    expect(page).to have_content('Favorites (1)')
    expect(page).to have_content(@pet_2.name)

    within('.favorite-pets') do
      expect(page).to_not have_content(@pet_1.name)
    end
  end

  it "the pet show page and unfavorite the pet" do
    visit "/pets/#{@pet_1.id}"
    click_link("Remove from Favorites")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("#{@pet_1.name} has been removed from your favorites")
    expect(page).to have_content('Favorites (1)')

    click_link('Favorites (1)')

    expect(page).to have_content(@pet_2.name)
    expect(page).to_not have_content(@pet_1.name)
  end

  it "the pets show page wont allow you to refavorite a pet" do
    expect(page).to have_link("Remove from Favorites")
    expect(page).to_not have_link("Favorite Pet")
  end
end
