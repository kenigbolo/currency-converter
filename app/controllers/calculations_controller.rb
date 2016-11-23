class CalculationsController < ApplicationController
  def create
    base = params[:calculation][:base_currency]
    conversion = params[:calculation][:conversion_currency]
    if base == conversion
      flash[:notice] = "You cannot convert from #{base} to #{conversion}"
    else
      save_calculation(calculation_params)
    end
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
