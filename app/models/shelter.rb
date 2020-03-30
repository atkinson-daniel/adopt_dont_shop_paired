class Shelter < ApplicationRecord
  has_many :pets
  has_many :reviews
  validates_presence_of :name, :address, :city, :state, :zip

  def any_pending_pets?
    pets.any? { |pet| pet[:adoption_status] == "Pending" }
  end

  def destroy_associated
    pets.destroy_all
    reviews.destroy_all
  end

  def average_rating
    rating = reviews.select(:rating).average(:rating)
    rating.to_f.round(1)
  end

  def count_of_pets
    pets.count
  end

  def count_of_applications
    counter = 0
    pets.each do |pet|
      counter += pet.applications.count
    end
    counter
  end

  def self.top_rated_shelters
    Shelter.all.sort_by { |shelter| shelter.average_rating }.reverse.take(3)
  end
end
