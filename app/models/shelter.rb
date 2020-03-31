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
    shelters = Review.joins(:shelter).group('shelter').order('average_rating desc').limit(3).average(:rating)
    shelters.keys
  end

  def sort_reviews(params)
    require "pry"; binding.pry
    if params[:review] == "desc"
      reviews.order(rating: :desc, created_at: :desc)
    else
      reviews.order(:rating, :created_at)
    end
  end
end
