class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :approximate_age, :sex, :image

  def update_adoption_status(adoption_status, approved_status, params)
    app = Application.find(params[:app_id])
    pet_app = PetApplication.where(application_id: app, pet_id: self)
    pet_app.update(approved: approved_status)
    self[:adoption_status] = adoption_status
    self.save
  end

  def approved_pet_app?(application, pet)
    pet_app = application.pet_applications.where(application_id: application, pet_id: pet)
    pet_app.first.approved
  end

  def applied_for?
    apps = PetApplication.where(pet_id: self.id)
    return false if apps.none?
    true
  end
end
