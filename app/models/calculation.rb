class Calculation < ApplicationRecord
  include HTTParty
  DEFAULT_DATE = (Date.today - 25).to_s
  WEEK = 7
  RATES = []
  belongs_to :user
  has_one :result
  validates :base_currency, :conversion_currency, :amount, :num_of_days, presence: true

  def remove_calculation!
    ActiveRecord::Base.transaction do
      result = Result.find_by(calculation_id: self.id)
      return false unless result.destroy && self.destroy
    end
    true
  end

  def save_calc!
    ActiveRecord::Base.transaction do
      return false unless self.save
    end
    self
  end

  def get_previous!
    response = HTTParty.get("http://fixer-node-api.herokuapp.com/#{DEFAULT_DATE}?base=#{self.base_currency}")
    return response.body
  end

  def get_current!
    response = HTTParty.get("http://fixer-node-api.herokuapp.com/latest?base=#{self.base_currency}")
    return response.body
  end

  def weeks!
    return self.num_of_days * WEEK
  end
end
