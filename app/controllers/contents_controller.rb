class ContentsController < ApplicationController
  helper :contents
  helper_method :content_to_html

  before_filter :authenticate_author!, :except => :show
  before_filter :get_content_by_id, :only => [:update, :destroy, :edit, :destroy_attachment]

  respond_to :html, :xml, :js

  # GET /contents
  # GET /contents.xml
  def index
    respond_with @contents = Content.all
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    category = Category.find :first, :conditions => ['url_alias = ?', params[:category_alias]]
    unless category.nil?
      @content = Content.find :first, :conditions => ['url_alias = ? AND category_id = ?', params[:url_alias], category.id]
      unless @content.nil?
        respond_with @content
        return
      end
    end
    error 404
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new
    @categories = Category.all
    @images = Image.all
  end

  def new_attachment
    @attachment = Attachment.new
  end

  # GET /contents/1/edit
  def edit
    @categories = Category.all
    @images = Image.all
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @content.author = current_author

    respond_to do |format|
      if @content.save
        format.html do
          flash[:notice] = t(:content_created) 
          redirect_to show_content_path(@content.category.url_alias, @content.url_alias)
        end
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        @categories = Category.all
        @images = Image.all
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /contents/1
  # PUT /contents/1.xml
  def update
    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html do
          flash[:notice] = t(:content_updated)
          redirect_to(show_content_path @content.category.url_alias, @content.url_alias)
        end
        format.xml  { head :ok }
      else
        @categories = Category.all
        @images = Image.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content.destroy
  
    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end

  def destroy_attachment
    @attachment = Attachment.find params[:aid]
    if @content.attachments.include? @attachment
      @attachment.destroy
    else
      error 500
    end
  end

  def add_comment
    category = Category.find :first, :conditions => ['url_alias = ?', params[:category_alias]]
    unless category.nil?
      @content = Content.find :first, :conditions => ['url_alias = ? AND category_id = ?', params[:url_alias], category.id]
      unless @content.nil?
        @comment = Comment.new params[:comment]
        @comment.content_id = @content.id
        if @comment.save
          Mailer.comment_notify(@comment, @content.author.email).deliver
          flash[:notice] = t(:comment_created)
        else
          flash[:alert] = t(:comment_errors)
        end
        redirect_to show_content_path(@content.category.url_alias, @content.url_alias)
        return
      end
    end
    error 404
  end

  def destroy_comment
    category = Category.find :first, :conditions => ['url_alias = ?', params[:category_alias]]
    unless category.nil?
      @content = Content.find :first, :conditions => ['url_alias = ? AND category_id = ?', params[:url_alias], category.id]
      unless @content.nil?
        @comment = Comment.find params[:id]
        @comment.destroy
        redirect_to show_content_path(@content.category.url_alias, @content.url_alias)
        return
      end
    end
    error 404
  end

  def preview_content
    render :text => TextileUtil.to_html(params[:data])
  end

  private
  def get_content_by_id
    @content = Content.find params[:id]
  end
end
