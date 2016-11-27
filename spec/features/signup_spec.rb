### Test for creating an account
require 'spec_helper'
require 'rails_helper'

RSpec.feature "Sign up", :type => :feature do
  describe 'Spec for Sign Up' do
    count = User.count
    before :each do
      visit new_user_registration_path
      email = 'abcd@example.com'
      username = 'test'
      fill_in 'user_username', :with => username
      fill_in 'user_email', :with => email
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
    end
    it 'should inform the with a welcome message' do
      click_button 'Sign up'
    	expect(page).to have_content 'Welcome! You have logged up successfully.'
    end
    it 'should create a new user account' do
      expect {
        click_button 'Sign up'
      }.to change {
        Calculation.count
      }.by(1)
    end
  end
end
