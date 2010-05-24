class FeedController < ApplicationController
  respond_to :xml

  def category
    @category = Category.find :first, :conditions => ['url_alias = ?', params[:url_alias]]
    unless @category.nil?
      @posts = Content.find :all, :order => 'created_at DESC', :conditions => ['published = 1 AND category_id = ?', @category.id], :limit => 10
      @title = @category.label
      @url = show_category_path :url_alias => @category.url_alias, :only_path => false
      render :feed, :layout => false
    else
      error 404
    end
  end

  def home
    @posts = Content.find :all, :order => 'created_at DESC', :conditions => 'published = 1', :limit => 10
    @title = t(:slogan)
    @controller = 'home'
    @url = index_path :only_path => false
    render :feed, :layout => false
  end

  def tag
    @tag = Tag.find :first, :conditions => ['url_alias =?', params[:tag]]
    unless @tag.nil?
      @posts = @tag.contents.order('created_at DESC').limit(10)
      @title = @tag.label
      @url = show_tag_path :url_alias => @tag.url_alias, :only_path => false
      render :feed, :layout => false
    else
      error 404
    end
  end
end
