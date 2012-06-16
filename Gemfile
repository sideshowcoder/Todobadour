source "https://rubygems.org"

# Gems required everywhere
gem "rails", "3.2.1"
gem "mysql"
gem "jquery-rails"
gem "best_in_place"
gem "friendly_id"
gem "ranked-model"

# required for remote push notifications
gem "foreman"
gem "thin"
gem "faye"

# Gems used only for assets production assets are precompieled and therefor this is not needed
group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "compass-rails"
  gem 'coffee-rails'
  gem "uglifier", ">= 1.0.3"
  gem 'jquery-ui-rails'
end

# Gems needed for testing and development
group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "webrat", "~> 0.7.3"
end

# Database for testing
group :test do
  gem "autotest"
  gem "autotest-growl"
  gem "autotest-fsevent"
  gem "factory_girl_rails"
  gem "sqlite3"
end

# Development Gems making life somewhat easier
group :development do
  gem "faker"
  gem "irbtools"
end