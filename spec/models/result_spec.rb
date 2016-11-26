require 'rails_helper'

RSpec.describe Result, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:result)).to be_valid
    end
  end

  context "it validates the credentials properly" do
    before :each do
      @result = FactoryGirl.build(:result)
    end
  end
end
