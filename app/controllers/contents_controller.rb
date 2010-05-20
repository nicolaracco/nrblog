class ContentsController < ApplicationController
  helper :contents
  helper_method :content_to_html

  before_filter :authenticate_author!, :except => :show
  before_filter :get_content_by_id, :only => [:update, :destroy, :edit, :destroy_attachment]
  before_filter :get_content_by_alias, :only => [:show]

  respond_to :html, :xml, :js

  # GET /contents
  # GET /contents.xml
  def index
    respond_with @contents = Content.all
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @comment = Comment.new
    respond_with @content
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new
    @content.author = current_author
    @categories = Category.all
  end

  def new_attachment
    @attachment = Attachment.new
  end

  # GET /contents/1/edit
  def edit
    @categories = Category.all
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @content.author = current_author

    respond_to do |format|
      if @content.save
        format.html do
          flash[:notice] = t(:notice, :scope => [:contents, :create]) 
          redirect_to show_content_path(:category_alias => @content.category.url_alias, :url_alias => @content.url_alias)
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
          flash[:notice] = t(:notice, :scope => [:contents, :update])
          redirect_to(show_content_path :category_alias => @content.category.url_alias, :url_alias => @content.url_alias)
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

  def preview_content
    render :text => TextileUtil.to_html(params[:data])
  end

  private
  def get_content_by_id
    @content = Content.find params[:id]
  end

  def get_content_by_alias
    category = Category.find :first, :conditions => ['url_alias = ?', params[:category_alias]]
    @content = Content.find :first, :conditions => ['url_alias = ? AND category_id = ?', params[:url_alias], category.id] unless category.nil?
    error 404 if @content.nil?
  end
end
