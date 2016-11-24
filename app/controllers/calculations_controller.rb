class CalculationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  RATES = []
  def index
  end

  def create
    base = params[:calculation][:base_currency]
    conversion = params[:calculation][:conversion_currency]
    if base == conversion
      flash['notice'] = "You cannot convert from #{base} to #{conversion}"
      redirect_back(fallback_location: root_path)
    else
      calc_to_convert = save_calculation(calculation_params)
      flash['notice'] = "#{conversion(calc_to_convert)}"
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
  def conversion(calc_to_convert)
    if calc_to_convert != false
      conv = calc_to_convert.conversion_currency.to_sym
      current_rate = eval(check_current_rate(calc_to_convert))#['rates'][conv]
      previous_rate = eval(check_previous_rate(calc_to_convert))#['rates'][conv]
      return conv_percentage(current_rate[:rates][conv], previous_rate[:rates][conv])
    end
  end
  def conv_percentage (current_rate, previous_rate)
    diff = ( (current_rate - previous_rate) / ( (current_rate + previous_rate) / 2 ) ) * 100
    change = ((1*diff)/25)
    return change
  end
  def check_current_rate(calc_to_convert)
    base = calc_to_convert.base_currency
    if RATES.empty?
      current_rate = calc_to_convert.get_current!
      RATES.push(current_rate)
      return current_rate
    else
      return current_rate(base, calc_to_convert)
    end
  end
  def check_previous_rate(calc_to_convert)
    base = calc_to_convert.base_currency
    if RATES.empty?
      previous_rate = calc_to_convert.get_previous!
      RATES.push(previous_rate)
      return previous_rate
    else
      return previous_rate(base, calc_to_convert)
    end
  end
  def current_rate(base, calc_to_convert)
    RATES.each do |rate|
      if rate['base'] == base && rate['date'] == Date.today.to_s
        return rate
      else
        current = calc_to_convert.get_current!
        RATES.push(current)
        return current
      end
    end
  end
  def previous_rate(base, calc_to_convert)
    RATES.each do |rate|
      if rate['base'] == base && rate['date'] == Calculation::DEFAULT_DATE
        return rate
      else
        previous = calc_to_convert.get_previous!
        RATES.push(previous)
        return previous
      end
    end
  end
end
