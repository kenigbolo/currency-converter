require 'rails_helper'

RSpec.describe Currency, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:currency)).to be_valid
    end
  end

  context "it validates the credentials properly" do
    before :each do
      @currency = FactoryGirl.build(:currency)
    end

    it "validates the presence of a currency name" do
      expect(@currency).to be_valid
    end
    it "validates the absence of a currency name" do
      @currency.name = nil
      expect(@currency).to_not be_valid
    end
  end
end
