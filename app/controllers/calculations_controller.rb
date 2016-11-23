class CalculationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
  end

  def create
    base = params[:calculation][:base_currency]
    conversion = params[:calculation][:conversion_currency]
    if base == conversion
      flash['notice'] = "You cannot convert from #{base} to #{conversion}"
    else
      save_calculation(calculation_params)
    end
    redirect_back(fallback_location: root_path)
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
    begin
      ActiveRecord::Base.transaction do
        calculation.save!
      end
      flash[:success_html_safe] = true
    rescue => e
      Rails.logger.warn e
      flash['error'] = 'Calculation could not be processed'
    end
  end
end
