class Review < ApplicationRecord
  belongs_to :shelter
  validates :rating, format: { with: /([1-5])/, message: "can only be between 1-5" }
  validates_presence_of :title, :rating, :content
end
