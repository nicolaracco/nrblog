class MenuItemsController < ApplicationController
  before_filter :authenticate_author!
  before_filter :get_menu_item, :only => [ :destroy, :update, :edit ]

  respond_to :html

  # GET /menu_items
  # GET /menu_items.xml
  def index
    @menu_items = MenuItem.all
    respond_with @menu_items
  end

  def show
    error 404
  end

  # GET /menu_items/new
  # GET /menu_items/new.xml
  def new
    @menu_item = MenuItem.new
    respond_with @menu_item
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items
  # POST /menu_items.xml
  def create
    @menu_item = MenuItem.new(params[:menu_item])
    fb = MenuItem.find(:first, :conditions => ['menu_type = ?', @menu_item.menu_type], :order => 'menu_order DESC')
    @menu_item.menu_order = fb.nil? ? 0 : fb.menu_order + 1
    
    if @menu_item.save
      flash[:notice] = t :menu_item_created
      redirect_to menu_items_url
    else
      render :action => :new
    end
  end

  # PUT /menu_items/1
  # PUT /menu_items/1.xml
  def update
    if @menu_item.update_attributes(params[:menu_item])
      flash[:notice] = t :menu_item_updated
      redirect_to menu_items_url
    else
      render :action => :edit
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.xml
  def destroy
    @menu_item.destroy

    redirect_to(menu_items_url)
  end

  private
  def get_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end
