require 'rails_helper'

describe "applications as a visitor" do
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

    @pet_2 = @shelter_1.pets.create(name: "Ruby",
                                    approximate_age: 2,
                                    sex: "Male",
                                    image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                                    description: "Test Description",
                                    adoption_status: "Adoptable")

    @pet_3 = @shelter_1.pets.create(name: "River",
                                    approximate_age: 4,
                                    sex: "Female",
                                    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRATvV2mL0wWqhpNXmsZtbsT4Zi8ElvfrE52Wvifx2C6N4P-M2S",
                                    description: "Test Description",
                                    adoption_status: "Adoptable")

    session = Favorite.new([@pet_1, @pet_2, @pet_3])
    allow_any_instance_of(ApplicationController).to receive(:favorites).and_return(session)
  end

  it "can create a new application" do

    visit "/pets"
    click_on("Favorites (3)")

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_3.name)

    click_on("Adopt Favorited Pets")

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

    expect(current_path).to eq("/favorites")
    expect(page).to have_content("Your application for #{@pet_1.name} and #{@pet_2.name} has been submitted.")

    within(".favorite-pets") do
      expect(page).to have_no_content(@pet_1.name)
      expect(page).to have_no_content(@pet_2.name)
      expect(page).to have_content(@pet_3.name)
    end
  end

  it "flashes an error message if form is incomplete" do

    visit "/applications/new"

    fill_in :address, with: "Test Address"
    fill_in :city, with: "Test city"
    fill_in :state, with: "Test State"
    fill_in :zip, with: "Test Zip"
    fill_in :phone_number, with: "Test Phone Number"
    fill_in :description, with: "Test Description"

    click_button("Submit Application")

    expect(page).to have_content("Unable to create application: Name can't be blank.")
  end
end
