
# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  let(:user) { FactoryGirl.build(:user) }
  describe '#create' do
    let(:reference_calculation) { FactoryGirl.build(:calculation) }
    let(:calculation_params) do
      { calculation:
        {
          base_currency: reference_calculation.base_currency,
          conversion_currency: reference_calculation.conversion_currency,
          amount: reference_calculation.amount,
          num_of_days: reference_calculation.num_of_days,
          user_id: reference_calculation.user_id
        } }
    end

    def create_calc
      post :create, params: calculation_params
    end

    context 'signed out' do
      it 'respond with an okay status' do
        expect(response).to have_http_status(200)
      end

      it 'is unauthorized' do
        expect do
          post :create, params: calculation_params
        end.to_not change {
          Calculation.count
        }
      end
    end

    context 'signed in' do
      login_user

      it 'respond with an okay status' do
        expect(response).to have_http_status(200)
      end

      it 'works' do
        expect do
          create_calc
        end.to change {
          Calculation.count
        }.by(1)
      end

      it 'redirects to results display page after successful calculation' do
        create_calc
        expect(response).to redirect_to(calculation_path(Calculation.last))
      end
    end
  end

  describe '#show' do
    let(:calculation) { FactoryGirl.create :calculation }
    let(:result) { FactoryGirl.create :result, calculation_id: calculation.id }
    context 'signed in' do
      login_user
      it 'works' do
        get :show, params: { id: calculation.id }
        response.should render_template('show')
      end
    end

    context 'signed out' do
      it 'Does not allow unauthroized viewing' do
        logout(:user)
        get :show, params: { id: calculation.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe '#destroy' do
    user = FactoryGirl.create(:user)
    let!(:calculation) { FactoryGirl.create(:calculation, user: user) }
    let(:calculation_params) { { id: calculation.id } }

    context 'signed in' do
      it 'works' do
        login_as(user, scope: :user)
        delete :destroy, params: calculation_params
        count = Calculation.count
        expect(Calculation.count).to eq(count)
      end

      context "attempting to delete an calculation I don't own" do
        let!(:calculation) { FactoryGirl.create(:calculation) }

        it 'is forbidden' do
          expect do
            delete :destroy, params: calculation_params
          end.to_not change {
            Calculation.count
          }
        end
      end
    end
  end
end
