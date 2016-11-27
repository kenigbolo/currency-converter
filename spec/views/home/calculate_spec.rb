### Test for creating an account
require 'spec_helper'
require 'rails_helper'
require 'capybara'

RSpec.feature "Sign up", :type => :feature do
  @controller = CalculationsController.new

  before :each do
    calculation = FactoryGirl.create(:calculation)
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    visit '/'
    find('#calculation_amount').set SecureRandom.random_number(25000)
    find('#calculation_amount').set SecureRandom.random_number(25000)
    find('#calculation_num_of_days').set SecureRandom.random_number(25000)
    select "EUR", :from => "calculation_base_currency"
    select "USD", :from => "calculation_conversion_currency"
  end
  describe 'Spec for Sign Up' do
    scenario 'it should inform the with a welcome message' do
    	expect(page).to have_content 'Meya Currency Predictor'
    end

    scenario "it allow you to click calculate button after filling the form" do
      expect(page).to have_button("calculate")
    end
  end
end
