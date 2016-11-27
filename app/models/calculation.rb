# frozen_string_literal: true
# rubocop:disable LineLength, MutableConstant
# ! Calculation Model
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
      unless Rails.env.test?
        result = Result.where(calculation_id: id)
        return false unless result.destroy_all && destroy!
      end
    end
    true
  end

  def save_calc!
    ActiveRecord::Base.transaction do
      return false unless save
    end
    self
  end

  def retrieve_previous!
    response = HTTParty.get("http://fixer-node-api.herokuapp.com/#{DEFAULT_DATE}?base=#{base_currency}")
    response.body
  end

  def retrieve_current!
    response = HTTParty.get("http://fixer-node-api.herokuapp.com/latest?base=#{base_currency}")
    response.body
  end

  def weeks!
    num_of_days * WEEK
  end
end
