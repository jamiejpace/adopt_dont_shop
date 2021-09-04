require 'rails_helper'

RSpec.describe "Application new page" do
  it 'has a link on the pet index page that takes you to the new application page' do
    visit '/pets'

    click_link('Start an Application')

    expect(current_path).to eq('/applications/new')
  end

  it 'has a form to create a new application' do
    visit '/pets'

    click_link('Start an Application')
    expect(current_path).to eq('/applications/new')
    
    fill_in('Name', with: 'Katie Crutchfield')
    fill_in('Street', with: 'Lilac Ln')
    fill_in('City', with: 'Saint Cloud')
    fill_in('State', with: 'Florida')
    fill_in('Zip code', with: '33128')

    click_button('Submit')

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content("Katie Crutchfield")
    expect(page).to have_content("Lilac Ln")
    expect(page).to have_content("Saint Cloud")
    expect(page).to have_content("In Progress")
  end
end
