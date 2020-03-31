require 'rails_helper'

describe "on the pets show page" do
  it "can view detailed pet info from id" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    pet_1 = shelter_1.pets.create(name: "Buddy",
                       approximate_age: 6,
                       sex: "Male",
                       image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                       description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                       adoption_status: "Adoptable")

    pet_2 = shelter_1.pets.create(name: "King",
                       approximate_age: 5,
                       sex: "Male",
                       image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
                       description: "His name might be King, but he'll treat you like royalty.",
                       adoption_status: "Pending")

    visit "/pets/#{ pet_1.id }"

    expect(page).to have_css("img[src*='#{pet_1.image}']")
    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.description)
    expect(page).to have_content(pet_1.approximate_age)
    expect(page).to have_content(pet_1.sex)
    expect(page).to have_content(pet_1.adoption_status)
    expect(page).to have_no_content(pet_2.name)
  end

  it "there's a link to view all applications, all applicants names which link to application show page" do

    shelter_1 = Shelter.create(name:    "Dumb Friends League",
                               address: "123 Fake Street",
                               city:    "Castle Rock",
                               state:   "CO",
                               zip:     "80104")

    pet_1 = shelter_1.pets.create(name: "Buddy",
                       approximate_age: 6,
                       sex: "Male",
                       image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                       description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                       adoption_status: "Adoptable")

    pet_2 = shelter_1.pets.create(name: "King",
                       approximate_age: 5,
                       sex: "Male",
                       image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png",
                       description: "His name might be King, but he'll treat you like royalty.",
                       adoption_status: "Pending")

    application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
    application_2 = Application.create(name: "David Tran", address: "72 Hallow St", city: "Castle Rock", state: "CO", zip: "80104", phone_number: "303-566-9242", description: "I'm eager to bring a new friend into my home.")
    application_3 = Application.create(name: "Aubree Smith", address: "9600 Shadow Ln", city: "Denver", state: "CO", zip: "80204", phone_number: "303-960-0240", description: "I love animals. Looking to add another to my family of two dogs, one cat, and one turtle.")

    PetApplication.create(application: application_1, pet: pet_1)
    PetApplication.create(application: application_2, pet: pet_1)
    PetApplication.create(application: application_3, pet: pet_2)


    visit "/pets/#{pet_1.id}"

    expect(page).to have_content(pet_1.name)
    click_link("All Applications")
    expect(current_path).to eq("/pets/#{pet_1.id}/applications")

    within(".list_of_applicants") do
      expect(page).to have_no_content(application_3.name)

      within("#application-#{application_1.id}")
        expect(page).to have_link(application_1.name)
      end

      within("#application-#{application_2.id}") do
        expect(page).to have_link(application_2.name)
        click_link(application_2.name)

        expect(current_path).to eq("/applications/#{application_2.id}")
      end

      within(".applicant_info") do
        expect(page).to have_content(application_2.name)
        expect(page).to have_content(application_2.address)
        expect(page).to have_content(application_2.state)
        expect(page).to have_content(application_2.zip)
        expect(page).to have_content(application_2.phone_number)
        expect(page).to have_content(application_2.description)
        expect(page).to have_link(pet_1.name)
      end
    end

    it "displays message if pet has no applications" do

      shelter_1 = Shelter.create(name:    "Dumb Friends League",
                                 address: "123 Fake Street",
                                 city:    "Castle Rock",
                                 state:   "CO",
                                 zip:     "80104")

      pet_1 = shelter_1.pets.create(name: "Buddy",
                        approximate_age: 6,
                        sex: "Male",
                        image: "https://hips.hearstapps.com/hmg- prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-  1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*",
                        description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!",
                        adoption_status: "Adoptable")

      visit "/pets/#{pet_1.id}/applications"

      expect(page).to have_content("This pet currently has no applications. :(")

    end

  end
