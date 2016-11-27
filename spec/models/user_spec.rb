require 'rails_helper'

RSpec.describe User, type: :model do
    context "valid Factory" do
      it "has a valid factory" do
        expect(FactoryGirl.build(:user)).to be_valid
      end
    end

    context "User from omniauth" do
      describe ".from_omniauth" do
        it "is expected to be_valid" do
          user = omniauth
          expect(user).to be_valid
        end
      end

      describe ".from_omniauth" do
        it "saves new user" do
          omniauth
          expect(User.all).should_not be_nil
        end
      end
    end

    before :each do
      @user = FactoryGirl.build(:user)
    end

    context "it validates the credentials properly" do
      it "should not be valid without a username" do
        @user.username = nil
        expect(@user).to_not be_valid
      end

      it "should not be valid without a password" do
        @user.password = nil
        expect(@user).to_not be_valid
      end

      it "should not be valid without an email" do
        @user.email = nil
        expect(@user).to_not be_valid
      end
    end

    context 'When a new User is initialized' do
      it 'is a new user' do
        expect(@user).to be_a_new(User)
      end

      it 'should be a valid User object' do
        expect(@user).to be_valid
      end
    end
end
