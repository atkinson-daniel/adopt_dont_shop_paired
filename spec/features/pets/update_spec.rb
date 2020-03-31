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
  end

  it "can edit detailed information from a pets id page" do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("Buddy")

    click_link("Update Pet")
    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")

    fill_in :name, with: "Rascal"
    fill_in :description, with: "Silly Rascal, Old Rascal"
    fill_in :sex, with: "Male"
    fill_in :approximate_age, with: 4
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/best-dog-quotes-1580508958.jpg?crop=0.670xw:1.00xh;0.167xw,0&resize=640:*"

    click_button("Update Pet")

    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("Rascal")
    expect(page).to have_content("Silly Rascal, Old Rascal")
    expect(page).to have_content("Male")
    expect(page).to have_content(4)
    expect(page).to have_css('img[src*="https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/best-dog-quotes-1580508958.jpg?crop=0.670xw:1.00xh;0.167xw,0&resize=640:*"]')
  end

  it "cannot update pet without all required fields filled in" do
    visit "/pets/#{@pet_1.id}"
    click_link("Update Pet")

    fill_in :name, with: ""
    fill_in :description, with: "Silly Rascal, Old Rascal"
    fill_in :sex, with: "Male"
    fill_in :approximate_age, with: 4
    fill_in :image, with: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/best-dog-quotes-1580508958.jpg?crop=0.670xw:1.00xh;0.167xw,0&resize=640:*"

    click_button("Update Pet")

    expect(page).to have_content("Unable to update pet: Name can't be blank.")
  end
end
