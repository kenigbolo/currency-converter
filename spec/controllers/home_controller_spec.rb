require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "allows authenticated access" do
    sign_in @user

    get :index

    expect(response).to be_success
  end
end
