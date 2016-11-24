class Calculation < ApplicationRecord
  include HTTParty
  DEFAULT_DATE = (Date.today - 25).to_s
  WEEK = 7
  belongs_to :user
  has_one :calculation
  validates :base_currency, :conversion_currency, :amount, :num_of_days, presence: true
  def remove_calculation!
    ActiveRecord::Base.transaction do
      return false unless self.destroy
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
    response = HTTParty.get("http://localhost:8080/#{DEFAULT_DATE}?base=#{self.base_currency}")
    return response.body
  end
  def get_current!
    response = HTTParty.get("http://localhost:8080/latest?base=#{self.base_currency}")
    return response.body
  end
  def weeks!
    return self.num_of_days * WEEK
  end
end
