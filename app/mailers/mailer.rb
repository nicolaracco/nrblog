class Mailer < ActionMailer::Base
  default :from => 'noreply@nicolaracco.com'

  def question(email_params, recipient)
    @sender_name = email_params[:name]
    @sender_email = email_params[:address]
    @message = email_params[:body]
    mail :to => recipient, :subject => "[#{t :sitename}] #{email_params[:subject]}"
  end

  def comment_notify(comment, recipient, content_url)
    @sender_name = comment.user_name
    @sender_email = comment.user_email
    @content = comment.content
    @message = comment.body
    @content_url = content_url
    mail :to => recipient, :subject => "[#{t :sitename}] #{t(:subject, :scope => [:mailer, :comment_notify], :content => comment.content.title)}"
  end
end
