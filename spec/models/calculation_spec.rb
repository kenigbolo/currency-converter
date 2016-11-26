require 'rails_helper'

RSpec.describe Calculation, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:calculation)).to be_valid
    end
  end

  context "it validates the credentials properly" do
    before :each do
      @calculation = FactoryGirl.build(:calculation)
    end
  end
end
