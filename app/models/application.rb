class Application < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def self.applications_by_pet(params)
    PetApplication.where(:pet_id == params[:pet_id]).map do |row|
      row.application
    end
  end
end
