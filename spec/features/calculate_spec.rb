# frozen_string_literal: true
### Test for creating an account
require 'spec_helper'
require 'rails_helper'
require 'capybara'

RSpec.feature 'Sign up', type: :feature do
  @controller = CalculationsController.new

  before :each do
    user = FactoryGirl.create(:user)
    login_as(user, scope: :user)
    calculate
  end

  describe 'Spec for Sign Up' do
    scenario 'it should inform the with a welcome message' do
      expect(page).to have_content 'Meya Currency Predictor'
    end

    scenario 'it allow you to click calculate button after filling the form' do
      expect(page).to have_button('calculate')
    end

    scenario 'It redirects to show result view path' do
      calculate = FactoryGirl.create(:calculation)
      expect do
        find('#calculate').click
      end.to change {
        current_path
      }.from(root_path).to(calculation_path(calculate.id + 1))
    end

    scenario 'It Creates a calculation' do
      expect do
        find('#calculate').click
      end.to change {
        Calculation.count
      }.by(1)
    end
  end
end
