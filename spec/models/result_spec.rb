require 'rails_helper'

RSpec.describe Result, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:result)).to be_valid
    end
  end

  before :each do
    @result = FactoryGirl.build(:result)
  end

  context "it validates the credentials properly" do
    it "is a valid result" do
      expect(@result).to be_valid
    end

    it "validates the absence of a result value" do
      @result.value = nil
      expect(@result).to_not be_valid
    end

    it "validates the absence of a calculation id" do
      @result.calculation_id = nil
      expect(@result).to_not be_valid
    end
  end

  context "returns top three values when the top_three! method is called" do
    it "column serialize Array" do
     expect(@result.value.is_a?(Hash)).to eq(true)
    end

    it "has returns top three" do
      top_three = [["2016-12-15", 1.6876348637933518], ["2016-11-24", 1.4274], ["2016-12-01", 0.35493080225355333]]
      expect(@result.top_three!).to eq(top_three)
    end
  end

  context "Has a valid association" do
    it { should belong_to(:calculation) }
  end
end
