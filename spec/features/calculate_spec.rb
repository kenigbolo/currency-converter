require 'rails_helper'
require 'spec_helper'
require "selenium-webdriver"

describe 'Adding a calculation', js: true do

  context "Signed in" do

    let!(:user){ FactoryGirl.create :user }

    it "Signed in user can make a calculation" do
      user_signed_in = true

      visit root_path

      find('#calculation_amount').set {SecureRandom.random_number(25000)}

      find('#calculation_num_of_days').set {SecureRandom.random_number(25000)}

      find("#calculation_base_currency[value='EUR']").select_option

      find("#calculation_conversion_currency[value='USD']").select_option

      expect {
        find('#calculate').click
        sleep 10
      }.to change {
        Calculation.count
      }.by(1)

      calculation = Calculation.last
      expect(calculation.base_currency).to eq 'EUR'
      expect(calculation.conversion_currency).to eq 'USD'

      expect {
        find('#calculate').click
        sleep 10
      }.to change {
        current_path
      }.from(root_path).to(calculation_path(Calculation.last))

    end

  end

end
