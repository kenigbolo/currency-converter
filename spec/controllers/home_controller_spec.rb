require 'rails_helper'
RSpec.describe HomeController, type: :controller do
  before do
    @user = FactoryGirl.create(:user)
  end

  it "Returns a 200 status OK" do
    get :index
    expect(response).to be_success
  end

  it "loads correctly" do
    controller_ok
  end

  it "allows authenticated access" do
    current_user = sign_in @user
    get :index
    expect(current_user).to_not eq(nil)
  end

  it "renders the right template" do
    get :index
    response.should render_template('index')
  end
end
