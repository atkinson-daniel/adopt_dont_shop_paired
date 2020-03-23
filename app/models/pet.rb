class Pet < ApplicationRecord
  belongs_to :shelter
  validates_presence_of :name, :approximate_age, :sex, :image
end
