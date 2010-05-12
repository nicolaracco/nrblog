class Mailer < ActionMailer::Base
  default :from => 'noreply@nicolaracco.com'

  def question(email_params, recipient)
    @sender_name = email_params[:name]
    @sender_email = email_params[:email]
    @message = email_params[:body]
    mail :to => recipient, :subject => "[#{t :sitename}] #{email_params[:subject]}"
  end

  def comment_notify(comment, recipient)
    @sender_name = comment.user_name
    @sender_email = comment.user_email
    @content = comment.content
    @message = comment.body
    mail :to => recipient, :subject => "[#{t :sitename}] New comment for #{comment.content.title}"
  end
end
