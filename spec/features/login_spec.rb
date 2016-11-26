require 'rails_helper'
require 'spec_helper'

describe 'Logging in' do

  let(:password){ SecureRandom.hex }

  def login_with_email
    login
    find('#user_login').set user.email
  end

  def login_with_username
    login
    find('#user_login').set user.username
  end

  def login
    visit root_path
    first("a[href='#{new_user_session_path}']").click
    find('#user_password').set user.password
  end

  def submit_form
    find('#new_user input[type=submit]').click
    sleep 3
  end

  context "Log in with email" do

    let!(:user){ FactoryGirl.create :user, password: password, password_confirmation: password }

    it "works" do

      login_with_email

      expect {
        submit_form
      }.to change {
        current_path
      }.from(new_user_session_path).to(root_path)

    end

  end

  context "Log in with username" do

    let!(:user){ FactoryGirl.create :user, password: password, password_confirmation: password }

    it "works" do

      login_with_username

      expect {
        submit_form
      }.to change {
        current_path
      }.from(new_user_session_path).to(root_path)

    end

  end

end
