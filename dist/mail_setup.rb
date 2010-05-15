ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => 'smtp.gmail.com',
  :port => 587,
  :domain => 'mysite.com',
  :authentication => :plain,
  :user_name => 'noreply@mysite.com',
  :password => 'pass'
}
