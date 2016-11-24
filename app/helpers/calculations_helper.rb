module CalculationsHelper
  RATES = []
  def conversion(calc_to_convert)
    if calc_to_convert != false
      conv = calc_to_convert.conversion_currency.to_sym
      current_rate = check_current_rate(calc_to_convert)
      previous_rate = check_previous_rate(calc_to_convert)
      return conv_percentage(current_rate[:rates][conv], previous_rate[:rates][conv])
    end
  end
  def conv_percentage (current_rate, previous_rate)
    diff = ( (current_rate - previous_rate) / ( (current_rate + previous_rate) / 2 ) ) * 100
    change = ((1*diff)/25)
    return change
  end
  # Helpers for current rate
  def check_current_rate(calc_to_convert)
    base = calc_to_convert.base_currency
    if RATES.empty?
      return current(calc_to_convert)
    else
      return current_rate(base, calc_to_convert)
    end
  end
  def current(calc_to_convert)
    current = eval(calc_to_convert.get_current!)
    RATES.push(current)
    return current
  end
  def current_rate(base, calc_to_convert)
    RATES.each do |rate|
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
    if RATES.empty?
      return previous(calc_to_convert)
    else
      return previous_rate(base, calc_to_convert)
    end
  end
  def previous(calc_to_convert)
    previous = eval(calc_to_convert.get_previous!)
    RATES.push(previous)
    return previous
  end
  def previous_rate(base, calc_to_convert)
    RATES.each do |rate|
      if rate[:base] == base && rate[:date] == Calculation::DEFAULT_DATE
        return rate
      else
        return previous(calc_to_convert)
      end
    end
  end
end
