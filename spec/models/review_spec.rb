require 'rails_helper'

describe Review do
  describe "relationships" do
    it { should belong_to :shelter}
  end

  describe "validations" do
    [:title, :rating, :content].each do |field|
      it { should validate_presence_of field }
    end
  end
end
