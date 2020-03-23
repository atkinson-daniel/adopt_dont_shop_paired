require 'rails_helper'

describe Pet do
  describe "validations" do
    [:name, :approximate_age, :sex, :image].each do |field|
      it { should validate_presence_of field }
    end
  end
end
