source "https://rubygems.org"

# Gems required everywhere
gem "rails", "3.2.8"
gem "pg"
gem "jquery-rails"
gem "best_in_place"
gem "friendly_id"
gem "ranked-model"
gem "coffee-rails"
gem "facebook_share"
gem "google-analytics-rails"

# required for remote push notifications and server
gem "foreman"
gem "thin"
gem "faye"

# Gems used only for assets production assets are precompieled and therefor this is not needed
group :assets do
  gem "sass-rails"
  gem "compass-rails"
  gem "uglifier"
  gem "jquery-ui-rails"
end

# Gems needed for testing and development
group :test, :development do
  gem "rspec-rails"
  gem "webrat"
  gem "vcr"
  gem "webmock", require: false
end

# Database for testing
group :test do
  gem "factory_girl_rails"
  gem "sqlite3"
end

# Development Gems making life somewhat easier
group :development do
  gem "mailcatcher"
  gem "faker"
end
