require 'rails_helper'

RSpec.describe "Application show page" do
  before :each do
    @shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Mose', shelter_id: @shelter.id)
    @application = Application.create(name: 'Jamie', street: '123 S Pearl St', state: "Colorado", city: "Denver", zip_code: "80212")
  end

  it 'displays the applicant name, full address, description, name of all pets applied for and application status' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.zip_code)
  end

  it 'can search for pets to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'Odell')

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Odell")
    end
  end

  it 'can search for partial matches to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'Ode')

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Odell")
    end
  end

  it 'can search for case insensitive matches to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'odell')

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Odell")
    end
  end

  it 'has a button to adopt pet next to pets from search results' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'Odell')

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")

      click_button('Adopt this Pet')

      expect(current_path).to eq("/applications/#{@application.id}")
    end

    within('#Application_details') do
      expect(page).to have_content("Odell")
    end
  end

  it 'has a submit section once you have added pets to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to_not have_content("Submit my Application")

      fill_in('Search by pet name', with: 'Odell')

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")

      click_button('Adopt this Pet')
      expect(current_path).to eq("/applications/#{@application.id}")
    end

    within('#Submit_application') do
      expect(page).to have_content("Submit Application")

      fill_in('Description', with: 'I love dogs')

      click_button("Submit My Application")

      expect(current_path).to eq("/applications/#{@application.id}")
    end

    expect(page).to have_content("Pending")
    expect(page).to_not have_content("Submit My Application")
    expect(page).to_not have_content("Add a Pet to this Application")
  end
end
