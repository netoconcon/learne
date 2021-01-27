ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => 587,
  :domain => "learne.com.br",
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :enable_starttls_auto => true 
}

ActionMailer::Base.delivery_method = :smtp