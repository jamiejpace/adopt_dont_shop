require 'rails_helper'

RSpec.describe 'Admin Shelters index' do
  it 'list shelters in reverse alphabetical order' do
    shelter_1 = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    shelter_2 = Shelter.create(name: 'Baker Shelter', city: 'Denver, CO', foster_program: true, rank: 6)
    shelter_3 = Shelter.create(name: 'City Park Shelter', city: 'Denver, CO', foster_program: false, rank: 1)

    visit '/admin/shelters'
    save_and_open_page

    expect(shelter_1.name).to appear_before(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_2.name)
  end

  it 'has a section that shows all pending applications' do
    shelter_1 = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    shelter_2 = Shelter.create(name: 'Baker Shelter', city: 'Denver, CO', foster_program: true, rank: 6)
    shelter_3 = Shelter.create(name: 'City Park Shelter', city: 'Denver, CO', foster_program: false, rank: 1)
    application_1 = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212", description: "I like dogs", status: "Pending")
    application_1.pets.create!(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter_1.id)

    visit '/admin/shelters'

    within('#Shelters_pending') do
      expect(page).to have_content("Shelter's with Pending Applications")
      expect(page).to have_content("Platt Park Shelter")
    end
  end
end
