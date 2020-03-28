class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip

  def any_pending_pets?
    pets.any? { |pet| pet[:adoption_status] == "Pending" }
  end

  def destroy_pets
    pets.destroy_all
  end
end
