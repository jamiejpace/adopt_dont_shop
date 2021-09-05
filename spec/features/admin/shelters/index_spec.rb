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
end
