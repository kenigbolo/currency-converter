class Calculation < ApplicationRecord
  belongs_to :user
  validates :base_currency, :conversion_currency, :amount, :num_of_days, presence: true
  def remove_calculation!
    ActiveRecord::Base.transaction do
      self.destroy!
    end
  end
end
