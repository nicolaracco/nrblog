class HomeController < ApplicationController
  def index
    @posts = Content.paginate :per_page => 5, :page => params[:page], :conditions => 'published = 1 AND in_home = 1', :order => 'created_at DESC'
  end

  #def search
  #end
end
