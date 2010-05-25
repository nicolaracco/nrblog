class Mailer < ActionMailer::Base
  default :from => 'noreply@nicolaracco.com'

  def question(contact, recipient)
    @sender_name = contact.user_name
    @sender_email = contact.user_email
    @message = contact.body
    mail :to => recipient, :subject => "[#{t :sitename}] #{contact.subject}"
  end
end
