class Result < ApplicationRecord
  belongs_to :calculation
  serialize :value
end
