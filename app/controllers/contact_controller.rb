class ContactController < ApplicationController
  before_filter :check_author

  def index
    @contact = Contact.new
  end

  def send_mail
    @contact = Contact.new params[:contact]
    if @contact.valid?
      Mailer.question(@contact, @author.email).deliver
      flash[:notice] = t(:notice, :scope => [:contact, :send_mail])
      redirect_to :root
    else
      render :index
    end
  end

  private
  def check_author
    @author = Author.find(:first, :conditions => ['username like ?', params[:author]])
    error 404 if @author.nil?
  end
end
