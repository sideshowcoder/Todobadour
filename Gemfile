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
gem "high_voltage"
gem "bourbon"
gem "neat"

# required server hosting on heroku
gem "foreman"
gem "subcontractor"
gem "thin"

# Gems used only for assets production assets are precompieled and therefor this is not needed
group :assets do
  gem "sass-rails"
  gem "compass-rails"
  gem "uglifier"
  gem "jquery-ui-rails"
end

# Gems needed for testing and development
group :test, :development do
  gem "therubyracer"
  gem "pry"
  gem "rspec-rails"
  gem "capybara"
  gem "poltergeist"
  gem "faker"
  gem "factory_girl_rails"
end

group :test do
  gem "database_cleaner"
end

# Development Gems making life somewhat easier
group :development do
  gem "mailcatcher"
end
