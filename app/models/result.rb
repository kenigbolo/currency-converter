# frozen_string_literal: true
class Result < ApplicationRecord
  belongs_to :calculation
  serialize :value, Hash
  validates :value, presence: true

  def top_three!
    value.sort_by { |_, v| -v }[0..2]
  end
end
