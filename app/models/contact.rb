class Contact 
  include ActiveModel::Validations

  validates_presence_of :user_name, :user_email, :body
  validates_format_of :user_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  attr_accessor :user_name, :user_email, :subject, :body

  def initialize(params={})
    @user_name, @user_email, @subject, @body = params[:user_name], params[:user_email], params[:subject], params[:body]
  end
end
