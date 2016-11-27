require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
    get :index
  end

  it "Returns a 200 status OK" do
    expect(response).to be_success
  end

  it "allows authenticated access" do
    current_user = sign_in @user
    expect(current_user).to_not eq(nil)
  end

  it "renders the right template" do
    response.should render_template('index')
  end
end
