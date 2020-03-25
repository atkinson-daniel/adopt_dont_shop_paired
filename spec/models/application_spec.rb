require 'rails_helper'

RSpec.describe Application do
  describe "validations" do
    [:name, :address, :city, :state, :zip, :phone_number, :description].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
      it { should have_many :pet_applications }
  end
end
