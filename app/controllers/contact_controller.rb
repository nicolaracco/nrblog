class ContactController < ApplicationController
  before_filter :check_author

  def index
  end

  def send_mail
    if params[:email][:name].empty? || params[:email][:address].empty? || params[:email][:body].empty?
      flash[:alert] = t(:needed, :scope => [:contact, :send_mail])
      render :index
    else
      Mailer.question(params[:email], @author.email).deliver
      flash[:notice] = t(:notice, :scope => [:contact, :send_mail])
      redirect_to :root
    end
  end

  private
  def check_author
    @author = Author.find(:first, :conditions => ['username like ?', params[:author]])
    error 404 if @author.nil?
  end
end
