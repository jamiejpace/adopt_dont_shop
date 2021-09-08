require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it {should have_many :pet_applications}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:zip_code) }
  end

  describe 'instance methods' do
    describe '.has_pets' do
      it 'returns assesses whether the application has any pets' do
        shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter.id)
        PetApplication.create(pet_id: pet_1.id, application_id: application1.id)

        expect(application1.has_pets).to be true
      end
    end

    describe '.in_progress?' do
      it 'returns true if status equals in progress' do
        shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter.id)

        expect(application1.in_progress?).to be true
      end
    end

    describe '.pending?' do
      it 'returns true if status is pending' do
        shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212", status: "Pending")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter.id)

        expect(application1.pending?).to be true
      end
    end

     describe '.update_status' do
       it 'changes status of application based on the pet applications statuses' do
         shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
         application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212")
         application2 = Application.create(name: 'Ron Swanson', street: '123 Bacon St', state: "Colorado", city: "Denver", zip_code: "80212")
         application3 = Application.create(name: 'April Ludgate', street: '123 Ghost St', state: "Colorado", city: "Denver", zip_code: "80212")
         pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter.id)
         pet_2 = Pet.create(adoptable: true, age: 4, breed: 'aussie', name: 'Huxley', shelter_id: shelter.id)
         PetApplication.create(pet_id: pet_1.id, application_id: application1.id, application_status: "Rejected")
         PetApplication.create(pet_id: pet_1.id, application_id: application2.id, application_status: "Approved")
         PetApplication.create(pet_id: pet_2.id, application_id: application3.id, application_status: "Pending")

         application2.update_status
         application1.update_status
         application3.update_status

         expect(application2.status).to eq("Approved")
         expect(application1.status).to eq("Rejected")
         expect(application3.status).to eq("Pending")
       end
    end
  end

  describe 'class methods' do
    describe '#find_pending_apps' do
      it 'finds all applications with pending status' do
        shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
        application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212", status: "Pending")
        application2 = Application.create(name: 'Ron Swanson', street: '123 Bacon St', state: "Colorado", city: "Denver", zip_code: "80212", status: "Pending")
        pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: shelter.id)
        PetApplication.create(pet_id: pet_1.id, application_id: application1.id, application_status: "Pending")
        PetApplication.create(pet_id: pet_1.id, application_id: application2.id, application_status: "Pending")

        expect(Application.find_pending_apps).to eq([application1, application2])
      end
    end
  end
end
