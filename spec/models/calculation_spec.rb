require 'rails_helper'

RSpec.describe Calculation, type: :model do
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryGirl.build(:calculation)).to be_valid
    end
  end

  context "Has a valid association" do
    it { should have_one(:result) }
    it { should belong_to(:user) }
  end

  before :each do
    @calculation = FactoryGirl.build(:calculation)
  end

  context "it validates the credentials properly" do
    it "Is a valid calculation" do
      expect(@calculation).to be_valid
    end

    it "validates the absence of calculation base_currency" do
      @calculation.base_currency = nil
      expect(@calculation).to_not be_valid
    end

    it "validates the absence of calculation conversion_currency" do
      @calculation.conversion_currency = nil
      expect(@calculation).to_not be_valid
    end

    it "validates the absence of calculation amount" do
      @calculation.amount = nil
      expect(@calculation).to_not be_valid
    end

    it "validates the absence of calculation num_of_days" do
      @calculation.num_of_days = nil
      expect(@calculation).to_not be_valid
    end
  end

  context "Returns the needed values for it's class methods" do
    it "returns the total number of days for week selection" do
      total_days = @calculation.num_of_days * 7
      expect(@calculation.weeks!).to eq(total_days)
    end

    it "deletes a calculation" do
      expect(@calculation.remove_calculation!).to eq(true)
    end

    it 'saves a valid calculation' do
      expect(@calculation.save_calc!).to eq(@calculation)
    end
  end
end
