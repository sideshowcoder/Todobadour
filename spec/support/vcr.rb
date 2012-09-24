require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock
  config.ignore_localhost = false
  config.default_cassette_options = { :record => :new_episodes }
end
