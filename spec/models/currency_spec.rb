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
  end
end
