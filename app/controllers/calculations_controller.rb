class CalculationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    @calculation = Calculation.new
  end

  def create
    base = params[:calculation][:base_currency]
    conversion = params[:calculation][:conversion_currency]
    if base == conversion
      flash['notice'] = "You cannot convert from #{base} to #{conversion}"
      redirect_back(fallback_location: root_path)
    else
      calc_to_convert = save_calculation(calculation_params)
      change_rate = helpers.conversion(calc_to_convert)
      flash['notice'] = "#{change_rate}"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    calculation = Calculation.find(params[:id])
    if calculation.user_id.present? && (current_user.id == calculation.user_id)
      success = false
      begin
        success = calculation.remove_calculation!
      rescue
        success = false
      end
      if success
        flash['notice'] = 'Calculation Prediction successfully deleted'
      else
        flash['error'] = 'Sorry, we encountered an error while deleting the currency prediction calculation'
      end
    else
      flash['error'] = 'You do not have the permission to delete this item'
    end
    redirect_back(fallback_location: root_path)
  end

  private
  def calculation_params
    params.require(:calculation).permit(:base_currency, :conversion_currency, :amount, :num_of_days)
  end
  def save_calculation(calculation_params)
    calculation = Calculation.new(calculation_params)
    calculation.user_id = current_user.id
    return calculation.save_calc!
  end
end
