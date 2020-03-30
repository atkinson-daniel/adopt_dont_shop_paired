class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.info(application, pet)
    PetApplication.create(application_id: application.id, pet_id: pet['id'])
  end

  def pet_name
    pet.name
  end

  def approve_application
    self[:approved] = true
    self.save
  end
end
