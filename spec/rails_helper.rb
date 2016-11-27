# frozen_string_literal: true
# rubocop:disable LineLength
require 'simplecov'
SimpleCov.start
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'controller_helpers'
require 'controller_marcos'
require 'helpers'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
  config.extend ControllerMacros, type: :controller
  config.extend ControllerMacros, type: :view
  config.extend ControllerMacros, type: :feature
  config.include Warden::Test::Helpers
  config.render_views
  config.after :each do
    Warden.test_reset!
  end

  config.include Helpers
  config.filter_rails_from_backtrace!
  Shoulda::Matchers.configure do |configure|
    configure.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
