# frozen_string_literal: true
module Helpers
  def login_with_username
    login
    find('#user_login').set user.username
  end

  def login
    visit new_user_session_path
    # first("a[href='#{new_user_session_path}']").click
    find('#user_password').set user.password
  end

  def submit_form
    find('#new_user input[type=submit]').click
    sleep 3
  end

  def login_with_email
    login
    find('#user_login').set user.email
  end

  def calculate
    visit '/'
    find('#calculation_amount').set SecureRandom.random_number(25_000)
    find('#calculation_amount').set SecureRandom.random_number(25_000)
    find('#calculation_num_of_days').set SecureRandom.random_number(25_000)
    select 'EUR', from: 'calculation_base_currency'
    select 'USD', from: 'calculation_conversion_currency'
  end

  def omniauth
    user = User.new
    user.provider = 'github'
    user.uid = SecureRandom.hex
    user.username = Faker::Internet.user_name
    user.email = Faker::Internet.email
    user.save!
    user
  end
end
