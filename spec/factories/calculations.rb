# frozen_string_literal: true
FactoryGirl.define do
  factory :calculation do
    base_currency 'EUR'
    conversion_currency 'USD'
    amount { SecureRandom.random_number(25_000) }
    num_of_days { SecureRandom.random_number(250) }
    user
  end
end
