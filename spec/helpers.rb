module Helpers
  def login_with_username
    login
    find('#user_login').set user.username
  end

  def login
    visit root_path
    first("a[href='#{new_user_session_path}']").click
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
    find('#calculation_amount').set {SecureRandom.random_number(25000)}

    find('#calculation_num_of_days').set {SecureRandom.random_number(25000)}

    find("#calculation_base_currency[value='EUR']").select_option

    find("#calculation_conversion_currency[value='USD']").select_option

    expect {
      find('#calculate').click
      sleep 10
    }.to change {
      Calculation.count
    }.by(1)
  end
end
