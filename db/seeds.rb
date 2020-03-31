# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
application_1 = Application.create(name: "Daniel Atkinson", address: "1853 26th St", city: "Boulder", state: "CO", zip: "80302", phone_number: "303-815-0297", description: "I am a animal lover and work from home, so I can constant care and attention to my new friend.")
application_2 = Application.create(name: "David Tran", address: "72 Hallow St", city: "Castle Rock", state: "CO", zip: "80104", phone_number: "303-566-9242", description: "I'm eager to bring a new friend into my home.")
application_3 = Application.create(name: "Aubree Smith", address: "9600 Shadow Ln", city: "Denver", state: "CO", zip: "80204", phone_number: "303-960-0240", description: "I love animals. Looking to add another to my family of two dogs, one cat, and one turtle.")

shelter_1 = Shelter.create(name: "Dumb Friends League", address: "123 Fake St", city: "Castle Rock", state: "CO", zip: "80104")
shelter_2 = Shelter.create(name: "Pawty Please", address: "000 Another Fake St", city: "Denver", state: "CO", zip: "80204")

pet_1 = shelter_1.pets.create(name: "Buddy", approximate_age: 6, sex: "Male", image: "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/single-minded-royalty-free-image-997141470-1558379890.jpg?crop=0.671xw:1.00xh;0.0847xw,0&resize=640:*", description: "Big things to come in big packages, you better be prepared to play with Buddy all day long!", adoption_status: "Adoptable")
pet_2 = shelter_2.pets.create(name: "King", approximate_age: 5, sex: "Male", image: "https://www.espree.com/sites/default/files/2019-10/DobermanPinscher.png", description: "His name might be King, but he'll treat you like royalty.", adoption_status: "Adoptable")
pet_3 = shelter_1.pets.create(name: "Zula", approximate_age: 4, sex: "Female", image: "https://getyourpet.com/wp-content/uploads/2018/09/pitbull-in-phoenix-yard.jpg", description: "Just the cutest bulldog ever who loves to smile!", adoption_status: "Adoptable")
pet_4 = shelter_2.pets.create(name: "River", approximate_age: 2, sex: "Male", image: "https://www.thelocal.fr/userdata/images/article/4b4e0dcd1ec9a4cab7f2c5923a674e1fbbaded4e64c4d2c34865dea52bfcd1ee.jpg", description: "River loves the water and sticks", adoption_status: "Pending")

shelter_1.reviews.create(title: "Best Animal Shelter", rating: 5, content: "I adopted Brownie and she was well trained. The staff are friendly and helpful.", picture:"https://m.media-amazon.com/images/M/MV5BMjg3MWFlMTQtZWNkYS00NDdiLWI4MzYtYmExYzdkMDlhMWY4XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_.jpg")
shelter_1.reviews.create(title: "Found My Forever Friend", rating: 2, content: "Today I brought home Simba. Very excited for him to be apart of our family.", picture:"https://www.mersive.com/wp-content/uploads/2019/07/Simba-hike-1024x768.jpg")

shelter_2.reviews.create(title: "Meow-tastic", rating: 5, content: "Wide selection of cats. I wanted to bring home all of them!")
shelter_2.reviews.create(title: "Best Bunnies", rating: 3, content: "Helpful staff, but small selection of bunnies. Luckily I fell in love with Marshmelone", picture:"https://images.unsplash.com/photo-1452857297128-d9c29adba80b?ixlib=rb-1.2.1&dpr=2&auto=format&fit=crop&w=416&h=312&q=60")

PetApplication.create(application: application_1, pet: pet_1)
PetApplication.create(application: application_2, pet: pet_2)
PetApplication.create(application: application_3, pet: pet_3)
PetApplication.create(application: application_3, pet: pet_1)
