class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :approximate_age, :sex, :image

  def update_adoption_status(pet, params)
    application = Application.find(params[:app_id])
    pet[:adoption_status] = "Pending"
    pet.save
  end
end
