class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications
  has_many :applications, through: :pet_applications
  validates_presence_of :name, :approximate_age, :sex, :image

  def self.favorited?
    Pet.where("favorited = true")
  end

  def self.unfavorite
    @pets = Pet.favorited?.map do |pet|
      pet[:favorited] = false
      pet.save
    end
  end
end
