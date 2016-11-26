class Currency < ApplicationRecord
  validates :name, presence: true
end
