# frozen_string_literal: true
source 'https://rubygems.org'
gem 'rails', '~> 6.0.3'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 6.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.10'
gem 'devise'
gem 'rubocop', require: false
gem 'omniauth'
gem 'omniauth-github'
gem 'httparty', '~> 0.18'
gem 'chartkick'
gem 'figaro'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 4.0'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'faker'
  gem 'shoulda-matchers'
end

group :test do
  gem 'selenium-webdriver', '3.142.7'
  gem 'rails-controller-testing'
end
group :production do
  gem 'pg', '~> 1.2'
  gem 'rails_12factor'
end
group :development do
  gem 'web-console'
  gem 'listen', '~> 3.2.1'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
