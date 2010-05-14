class HomeController < ApplicationController
  def index
    @posts = Content.paginate :page => params[:page], :conditions => 'published = 1 AND in_home = 1', :order => 'created_at DESC'
  end

  #def search
  #end
end
