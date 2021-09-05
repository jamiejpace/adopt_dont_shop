class Application < ApplicationRecord
  validates :name, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true, numericality: true, length: { is: 5 }
  has_many :pet_applications, dependent: :delete_all
  has_many :pets, through: :pet_applications

  def has_pets
    pets.count >= 1
  end
end
