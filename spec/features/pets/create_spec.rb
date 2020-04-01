require 'rails_helper'

describe "shelter pets index page" do
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
  end

  it "can create a new pet with related shelter_id" do
    visit "/shelters/#{@shelter_1.id}/pets"

    expect(page).to have_content("Buddy")
    expect(page).to have_no_content("Rascal")
    click_link("Create Pet")

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets/new")

    fill_in :name, with: "Rascal"
    fill_in :image, with: "https://starecat.com/content/wp-content/uploads/you-think-drawing-eyebrows-on-me-is-funny-robert-silly-dog.jpg"
    fill_in :Description, with: "Silly Rascal"
    fill_in :approximate_age, with: 10
    fill_in :sex, with: "Male"

    click_button("Create Pet")

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
    expect(page).to have_content("Buddy")
    expect(page).to have_content("Rascal")
    expect(page).to have_content(10)
    expect(page).to have_css('img[src*="https://starecat.com/content/wp-content/uploads/you-think-drawing-eyebrows-on-me-is-funny-robert-silly-dog.jpg"]')
  end

  it "cannot create a pet with missing fields" do
    visit "/shelters/#{@shelter_1.id}/pets"
    click_link("Create Pet")

    fill_in :image, with: "https://starecat.com/content/wp-content/uploads/you-think-drawing-eyebrows-on-me-is-funny-robert-silly-dog.jpg"
    fill_in :Description, with: "Silly Rascal"
    fill_in :sex, with: "Male"

    click_button("Create Pet")

    expect(page).to have_content("Unable to create pet: Name can't be blank and Approximate age can't be blank")
    expect(current_path).to eq("/shelters/#{@shelter_1.id}/pets")
  end
end
