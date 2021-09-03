class Application < ApplicationRecord
  has_many :pet_applications, dependent: :delete_all
  has_many :pets, through: :pet_applications
end
