require 'rails_helper'

describe "applications show page" do
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

    @pet_2 = @shelter_1.pets.create(name: "King",
      approximate_age: 5,
      sex: "Male",
      image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
      description: "His name might be King, but he'll treat you like royalty.",
      adoption_status: "Adoptable")

    @application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
    @application_2 = Application.create(name: "David Tran", address: "123 Fake St", city: "Castle Rock", state: "CO", zip: "80129", phone_number: "303-555-5555", description: "Aniamls Rock.")

    PetApplication.create(application: @application_1, pet: @pet_1)
    PetApplication.create(application: @application_1, pet: @pet_2)
    PetApplication.create(application: @application_2, pet: @pet_1)
  end

  it "can approve an application" do
    visit "/applications/#{@application_1.id}"

    within("#pet_application_#{@pet_2.id}") do
      expect(page).to have_link(@pet_2.name)
      expect(page).to have_link("Approve Application")
    end

    within("#pet_application_#{@pet_1.id}") do
      expect(page).to have_link(@pet_1.name)
      click_link("Approve Application")
    end

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Adoption Status: Pending")
    expect(page).to have_content("#{@pet_1.name} is on hold for #{@application_1.name}.")
  end

  it "cannot approve more than one application for a single pet" do
    visit "/applications/#{@application_1.id}"

    within("#pet_application_#{@pet_1.id}") do
      click_link "Approve Application"
    end

    expect(page).to have_content("#{@pet_1.name} is on hold for #{@application_1.name}.")

    visit "/applications/#{@application_2.id}"

    within("#pet_application_#{@pet_1.id}") do
      click_link "Approve Application"
    end

    expect(page).to have_content("No more applications can be approved for #{@pet_1.name} at this time")
  end

  it "can unapprove an application" do
    visit "/applications/#{@application_1.id}"

    within("#pet_application_#{@pet_1.id}") do
      click_link "Approve Application"
    end

    visit "/applications/#{@application_1.id}"

    within("#pet_application_#{@pet_1.id}") do
      expect(page).to have_link("Unapprove Application")
      expect(page).to_not have_link("Approve Application")
    end

    click_link "Unapprove Application"
    expect(current_path).to eq("/applications/#{@application_1.id}")

    within("#pet_application_#{@pet_1.id}") do
      expect(page).to_not have_link("Unapprove Application")
      expect(page).to have_link("Approve Application")
    end

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Adoption Status: Adoptable")
    expect(page).to_not have_content("Adoption Status: Pending")
  end
end
