require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  @controller = CalculationsController.new
  @user = FactoryGirl.create(:user)
  describe '#create' do
    let(:reference_calculation){ FactoryGirl.build(:calculation) }
    let(:calculation_params){
      {calculation:
        {
          base_currency: reference_calculation.base_currency,
          conversion_currency: reference_calculation.conversion_currency,
          amount: reference_calculation.amount,
          num_of_days: reference_calculation.num_of_days,
          user_id: reference_calculation.user_id
        }
      }
    }

    def create_calc
      post :create, params: calculation_params
    end

    context "signed out" do

      it "respond with an okay status" do
        expect(response).to have_http_status(200)
      end

      it "is unauthorized" do
        expect {
          post :create, params: calculation_params
        }.to_not change {
          Calculation.count
        }
      end

    end

    context "signed in" do
      login_user
      
      it "respond with an okay status" do
        expect(response).to have_http_status(200)
      end

      it "works" do
        expect {
          create_calc
        }.to change {
          Calculation.count
        }.by(1)
      end

      it "redirects to results display page after successful calculation" do
        create_calc
        expect(response).to redirect_to(calculation_path(1))
      end
    end

  end

end
