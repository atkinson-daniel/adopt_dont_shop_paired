require 'rails_helper'

describe Pet do
  describe "validations" do
    [:name, :approximate_age, :sex, :image].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
    it { should have_many :pet_applications}
    it { should have_many(:applications).through(:pet_applications)}
  end
end
