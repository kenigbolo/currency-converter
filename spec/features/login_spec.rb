require 'rails_helper'
require 'spec_helper'

describe 'Logging in' do

  let(:password){ SecureRandom.hex }

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
