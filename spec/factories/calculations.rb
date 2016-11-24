FactoryGirl.define do
  factory :calculation do
    base_currency "MyString"
    conversion_currency "MyString"
    amount 1.5
    num_of_days 1
    user nil
  end
end
