class CategoriesController < ApplicationController
  before_filter :authenticate_author!, :except => :show
  before_filter :get_category, :only => [:edit, :update, :destroy]

  respond_to :html, :js, :xml

  # GET /categories
  # GET /categories.xml
  def index
    respond_with(@categories = Category.all)
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    @category = Category.find :first, :conditions => ['url_alias = ?', params[:url_alias]]
    unless @category.nil?
      @posts = Content.paginate :page => params[:page], :conditions => ['published = 1 AND category_id = ?', @category.id], :order => 'created_at DESC'
      render :show
    else
      error 404
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    respond_with(@category = Category.new)
  end

  # GET /categories/1/edit
  def edit
    respond_with @category
  end

  # POST /categories
  # POST /categories.xml
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { flash[:notice] = t(:notice, :scope => [:categories, :create]); redirect_to :action => :index; }
        format.js { render 'create' }
      else
        format.html { render :action => :new }
        format.js { render 'showerrors' }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    respond_to do |format|
      if @category.update_attributes params[:category]
        format.html { flash[:notice] = t(:notice, :scope => [:categories, :update]); redirect_to :action => :index; }
      else
        format.html { render :action => :edit }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    @category.destroy

    redirect_to(categories_url)
  end

  private
  def get_category
    @category = Category.find params[:id]
  end
end
