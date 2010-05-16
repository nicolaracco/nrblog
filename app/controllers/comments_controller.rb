class CommentsController < ApplicationController
  before_filter :authenticate_author!, :except => [:index, :show, :add, :create]
  before_filter :get_content_by_alias
  before_filter :get_comment, :only => [:show, :edit, :update, :destroy]

  respond_to :html, :js

  def index
    respond_with @comments = Comment.paginate(:page => params[:page], :order => 'created_at DESC', :conditions => ['content_id = ?', @content.id])
  end

  def show
    respond_with @comment
  end

  def new
    @comment = Comment.new
    @comment.content = @content
    respond_with @comment
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.content = @content

    respond_to do |format|
      if @comment.save
        format.html do
          flash[:notice] = t(:comment_created)
          redirect_to :action => :index
        end
        format.js do 
          @comments = Comment.paginate(:page => params[:page], :order => 'created_at DESC', :conditions => ['content_id = ?', @content.id])
          render :index
        end
      else
        format.html { render :action => :new }
        format.js { render 'showerrors' }
      end
    end
  end

  def edit
    respond_with @comment
  end

  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html do
          flash[:notice] = t(:comment_updated)
          redirect_to :action => :index
        end
      else
        format.html { render :action => :edit }
      end
    end
  end

  def destroy
    @comment.destroy
   redirect_to :action => :index 
  end

  private
  def get_content_by_alias
    category = Category.find :first, :conditions => ['url_alias = ?', params[:category_alias]]
    @content = Content.find :first, :conditions => ['url_alias = ? AND category_id = ?', params[:url_alias], category.id] unless category.nil?
    error 404 if @content.nil? || !@content.has_comments
  end

  def get_comment
    @comment = Comment.find params[:id]
  end
end
