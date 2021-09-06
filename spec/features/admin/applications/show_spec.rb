require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve application next to each pet on application' do
    shelter_1 = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter_1.id)
    pet_4 = Pet.create(adoptable: true, age: 2, breed: 'aussie', name: 'Huxley', shelter_id: shelter_1.id)
    application_1 = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212", description: "I love dogs", status: "Pending")
    PetApplication.create(pet: pet_1, application: application_1)
    
    visit "/admin/applications/#{application_1.id}"
    save_and_open_page
    click_button("Approve Application for #{pet_1.name}")
  end
end
