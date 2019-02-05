# frozen_string_literal: true
source 'https://rubygems.org'
gem 'rails', '~> 5.0.7'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'devise'
gem 'rubocop', require: false
gem 'omniauth'
gem 'omniauth-github'
gem 'httparty', '~> 0.13'
gem 'chartkick'
gem 'figaro'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.8'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'faker'
  gem 'shoulda-matchers'
end

group :test do
  gem 'selenium-webdriver', '2.53.4'
  gem 'rails-controller-testing'
end
group :production do
  gem 'pg', '~> 0.18'
  gem 'rails_12factor'
end
group :development do
  gem 'web-console'
  gem 'listen', '~> 3.1.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
