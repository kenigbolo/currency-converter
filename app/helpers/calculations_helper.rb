module CalculationsHelper
  def get_result(calc_to_convert)
    today_value = rate_today(calc_to_convert)
    calc_to_convert.current_rate = today_value
    calc_to_convert.save!
    value = calculate_result(calc_to_convert, today_value)
    Result.create!(value: value, calculation_id: calc_to_convert.id)
  end
  def calculate_result(calc_to_convert, today_value)
    change_rate = conversion(calc_to_convert)
    days = calc_to_convert.weeks!
    daily_value = today_value
    count = 1
    value = {(Date.today.to_s) => today_value}
    (count..days).each do |daily_rate|
      if ((daily_rate % Calculation::WEEK) == 0)
        # Add a Standard random value deviation using international -0.5 to 1.0 change rate in currency forecasting
        daily_value += (change_rate + rand(-0.5..1.0))
        value[(Date.today + daily_rate).to_s] = daily_value
        count += 1
      end
    end
    return value
  end
  def week_number(week)
    return (Date.parse week).cweek
  end
  def rate_today(calc_to_convert)
    conv = calc_to_convert.conversion_currency.to_sym
    current_rate = check_current_rate(calc_to_convert)
    return current_rate[:rates][conv]
  end

  def conversion(calc_to_convert)
    if calc_to_convert != false
      conv = calc_to_convert.conversion_currency.to_sym
      current_rate = check_current_rate(calc_to_convert)
      previous_rate = check_previous_rate(calc_to_convert)
      return conv_percentage(current_rate[:rates][conv], previous_rate[:rates][conv])
    end
  end

  # Algorithm for calculating average percentage change over the past 25 weeks
  def conv_percentage (current_rate, previous_rate)
    # Increase or decrease in value
    diff = ( (current_rate - previous_rate) / ( (current_rate + previous_rate) / 2 ) ) * 100
    # Weekly change algorithm
    change = ((7*diff)/25)
    return change
  end

  # Helpers for current rate
  def check_current_rate(calc_to_convert)
    base = calc_to_convert.base_currency
    if Calculation::RATES.empty?
      return current(calc_to_convert)
    else
      return current_rate(base, calc_to_convert)
    end
  end
  def current(calc_to_convert)
    current = eval(calc_to_convert.get_current!)
    Calculation::RATES.push(current)
    return current
  end
  def current_rate(base, calc_to_convert)
    Calculation::RATES.each do |rate|
      if rate[:base] == base && rate[:date] == Date.today.to_s
        return rate
      else
        return current(calc_to_convert)
      end
    end
  end

  # Helpers for previous rates
  def check_previous_rate(calc_to_convert)
    base = calc_to_convert.base_currency
    if Calculation::RATES.empty?
      return previous(calc_to_convert)
    else
      return previous_rate(base, calc_to_convert)
    end
  end
  def previous(calc_to_convert)
    previous = eval(calc_to_convert.get_previous!)
    Calculation::RATES.push(previous)
    return previous
  end
  def previous_rate(base, calc_to_convert)
    Calculation::RATES.each do |rate|
      if rate[:base] == base && rate[:date] == Calculation::DEFAULT_DATE
        return rate
      else
        return previous(calc_to_convert)
      end
    end
  end
  # Helpers for calculation view
  def exchange_rate (calculation, result)
    if result.class == Array
      return (calculation.current_rate + result.second ).round(4)
    else
      return (calculation.current_rate + result).round(4)
    end
  end
  def exchange_total_amount(calculation, result)
    return (exchange_rate(calculation, result) * calculation.amount).round(4)
  end
  def profit_loss(calculation, result)
    return (exchange_total_amount(calculation, result) - (calculation.current_rate * calculation.amount)).round(2)
  end
end
