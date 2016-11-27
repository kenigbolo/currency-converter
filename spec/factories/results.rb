# frozen_string_literal: true
FactoryGirl.define do
  VALUE = { '' => 0, '2016-11-24' => 1.4274, '2016-12-01' => 0.35493080225355333, '2016-12-08' => -0.4564509171633422, '2016-12-15' => 1.6876348637933518 }.freeze
  factory :result do
    value VALUE
    calculation
  end
end
