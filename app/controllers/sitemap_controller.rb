class SitemapController < ApplicationController
  respond_to :xml

  def index
    @posts = Content.find(:all, :conditions => 'published = 1', :order => 'updated_at DESC', :limit => 50000)
    @categories = Category.find(:all)
    @tags = Tag.find(:all)
    render :layout => false
  end
end
