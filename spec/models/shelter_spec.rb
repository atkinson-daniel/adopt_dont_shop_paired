require 'rails_helper'

describe Shelter do
  describe "validations" do
    [:name, :address, :city, :state, :zip].each do |field|
      it { should validate_presence_of field }
    end
  end

  describe "relationships" do
    it { should have_many :pets }
  end
end
