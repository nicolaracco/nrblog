class TagsController < ApplicationController
  before_filter :authenticate_author!
  before_filter :get_tag, :only => [:edit, :update, :destroy]

  respond_to :html
 
  # GET /tags
  # GET /tags.xml
  def index
    respond_with @tags = Tag.all
  end

  def show
    @tag = Tag.find :first, :conditions => ['url_alias = ?', params[:tag]]
    unless @tag.nil?
      unless check_empty_tag
        @posts = Content.paginate :per_page => 5, :page => params[:page], :conditions => ['published = 1 AND id IN (SELECT content_id FROM contents_tags WHERE tag_id = ?)', @tag.id], :order => 'created_at DESC'
      end
    else
      error 404
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    respond_with @tag = Tag.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])

    if @tag.save
      flash[:notice] = t(:tag_created)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    if @tag.update_attributes(params[:tag])
      flash[:notice] = t(:tag_updated)
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag.destroy
    redirect_to :action => :index
  end

  private
  def check_empty_tag
    flash[:alert] = t(:tag_empty) if @tag.contents.empty?
    return @tag.contents.empty?
  end

  def get_tag
    @tag = Tag.find params[:id]
  end
end
