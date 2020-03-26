class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.info(application, pet)
    PetApplication.create(application: application, pet: pet)
  end
end
