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

  before :each do
    @shelter = Shelter.create(name: 'Platt Park Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet_1 = Pet.create(adoptable: true, age: 4, breed: 'poodle', name: 'Odell', shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Mose', shelter_id: @shelter.id)
    @application1 = Application.create(name: 'Leslie Knope', street: '123 Waffle St', state: "Colorado", city: "Denver", zip_code: "80212")
    @application2 = Application.create(name: 'Ron Swanson', street: '123 Bacon St', state: "Colorado", city: "Denver", zip_code: "80212")
    @application3 = Application.create(name: 'April Ludgate', street: '123 Ghost St', state: "Colorado", city: "Denver", zip_code: "80212")
    PetApplication.create(pet: @pet_1, application: @application1)
    PetApplication.create(pet: @pet_1, application: @application2)
  end

  describe 'instance methods' do
    describe '#has_pets' do
      it 'returns assesses whether the application has any pets' do
        expect(@application1.has_pets).to be true
      end
    end
  end
end
