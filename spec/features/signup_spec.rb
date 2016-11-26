### Test for creating an account
require 'spec_helper'
require 'rails_helper'

RSpec.feature "Sign up", :type => :feature do
  describe 'Spec for Sign Up' do
    before :each do
      visit new_user_registration_path
      email = 'abcd@example.com'
      username = 'test'
      fill_in 'user_username', :with => username
      fill_in 'user_email', :with => email
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
      click_button 'Sign up'
    end
    it 'should inform the with a welcome message' do
    	expect(page).to have_content 'Welcome! You have logged up successfully.'
    end
    it 'should create a new user account' do
      expect(User.count).to eq(1)
    end
  end
end
