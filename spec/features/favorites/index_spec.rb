require 'rails_helper'

describe "as a visitor" do
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
      click_on("Favorite Pet")

      visit "/pets/#{@pet_2.id}"
      click_on("Favorite Pet")
  end

  it "can see all pets favorited" do
    visit "/pets"
    expect(page).to have_no_content("Favorited Pets")
    click_on("Favorites (2)")

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Favorited Pets")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_no_content(@pet_3.name)

    click_on("Remove All Favorites")

    expect(current_path).to eq("/favorites")
    expect(page).to have_no_content(@pet_1.name)
    expect(page).to have_no_content(@pet_2.name)
    expect(page).to have_no_content(@pet_3.name)
    expect(page).to have_content("Favorites (0)")
  end

  it "can see a list of all the pets that have at least one application on them" do
    visit "/favorites"
    click_link "Adopt Favorited Pets"

    expect(current_path).to eq("/applications/new")
    check(@pet_1.id)
    check(@pet_2.id)
    fill_in :name, with: "Test Name"
    fill_in :address, with: "Test Address"
    fill_in :city, with: "Test city"
    fill_in :state, with: "Test State"
    fill_in :zip, with: "Test Zip"
    fill_in :phone_number, with: "Test Phone Number"
    fill_in :description, with: "Test Description"

    click_button("Submit Application")

    within(".favorite-pets") do
      expect(page).to have_no_content(@pet_1.name)
      expect(page).to have_no_content(@pet_2.name)
    end

    within(".pets-applied-for") do
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_link(@pet_2.name)
    end
  end

  it "can see a list of pets that have an approved application" do

    application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
    application_2 = Application.create(name: "David Tran", address: "72 Hallow St", city: "Castle Rock", state: "CO", zip: "80104", phone_number: "303-566-9242", description: "I'm eager to bring a new friend into my home.")
    pet_app_1 = PetApplication.create(application: application_1, pet: @pet_1)
    pet_app_2 = PetApplication.create(application: application_2, pet: @pet_3)

    pet_app_1.approve_application
    pet_app_2.approve_application

    visit "/favorites"

    within(".pets-pending") do
      expect(page).to have_content("Pets with Approved Applications")
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_link(@pet_3.name)
    end
  end
end
