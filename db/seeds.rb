# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Veterinarian.destroy_all
VeterinaryOffice.destroy_all
Shelter.destroy_all
Pet.destroy_all
Application.destroy_all
PetApplication.destroy_all

shelter_1 = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
shelter_2 = Shelter.create(name: 'Baker Shelter', city: 'Denver, CO', foster_program: true, rank: 6)
shelter_3 = Shelter.create(name: 'City Park Shelter', city: 'Denver, CO', foster_program: false, rank: 1)
pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter_1.id)
pet_2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Mose', shelter_id: shelter_2.id)
pet_3 = Pet.create(adoptable: true, age: 12, breed: 'lab', name: 'Phoebe', shelter_id: shelter_3.id)
pet_4 = Pet.create(adoptable: true, age: 2, breed: 'aussie', name: 'Huxley', shelter_id: shelter_1.id)
application_1 = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212")
application_2 = Application.create(name: 'Megan', street: '456 Walnut Dr', state: "Colorado", city: "Denver", zip_code: "90210")
application_3 = Application.create(name: 'Steve', street: '879 Juniper Ln', state: "Colorado", city: "Denver", zip_code: "77834")
PetApplication.create(pet_id: pet_1.id, application_id: application_1.id)
PetApplication.create(pet_id: pet_2.id, application_id: application_1.id)
PetApplication.create(pet_id: pet_4.id, application_id: application_3.id)
