class SitemapController < ApplicationController
  respond_to :xml

  def index
    respond_with @posts = Content.find(:all, :conditions => 'published = 1', :order => 'updated_at DESC', :limit => 50000)
  end
end
