if Rails.env.development?
  require 'development_mail_interceptor'
  # Use GMail during development
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :domain               => "example.com",
    :user_name            => "philipp.fehre@googlemail.com",
    :password             => "iw06jtfV",
    :authentication       => "plain",
    :enable_starttls_auto => true
  }
  ActionMailer::Base.default_url_options[:host] = "localhost:3000"
  ActionMailer::Base.register_interceptor DevelopmentMailInterceptor
elsif Rails.env.production?
  # Use SendGrid on Heroku
  ActionMailer::Base.smtp_settings = {
    :address              => "smtp.sendgrid.net",
    :port                 => 587,
    :user_name            => ENV['SENDGRID_USERNAME'],
    :password             => ENV['SENDGRID_PASSWORD'],
    :domain               => 'heroku.com',
    :authentication       => "plain"
  }
  ActionMailer::Base.default_url_options[:host] = "todobadour.herokuapp.com"
end
