class MenuItemsController < ApplicationController
  before_filter :authenticate_author!
  before_filter :get_menu_item, :only => [ :destroy, :update, :edit, :change_order, :change_type ]

  respond_to :html

  # GET /menu_items
  # GET /menu_items.xml
  def index
    items = MenuItem.find(:all, :order => 'menu_order ASC')
    @menu_items = {}
    items.each do |item|
      sype = item.menu_type.to_sym
      @menu_items[sype] = [] if @menu_items[sype].nil?
      @menu_items[sype] << item
    end
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
      flash[:notice] = t :notice, :scope => [:menu_items, :create]
      redirect_to menu_items_url
    else
      render :action => :new
    end
  end

  # PUT /menu_items/1
  # PUT /menu_items/1.xml
  def update
    if @menu_item.update_attributes(params[:menu_item])
      flash[:notice] = t :notice, :scope => [:menu_items, :update]
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

  def change_order
    errors = {}
    old_pos = @menu_item.menu_order
    new_pos = params[:new_pos].to_i

    subset = MenuItem.find(:all, :conditions => ['menu_type = ?', @menu_item.menu_type], :order => 'menu_order ASC')
    subset[(old_pos + 1)..new_pos].each { |item| item.menu_order -= 1 } if new_pos > old_pos
    subset[new_pos..(old_pos - 1)].each { |item| item.menu_order += 1 } if new_pos < old_pos
    @menu_item.menu_order = new_pos
    subset.each do |item| 
      item.save
      errors[item.title] = item.errors if item.errors.any?
    end
    @menu_item.save
    errors[@menu_item.title] = @menu_item.errors if @menu_item.errors.any?

    render :text => errors.any? ? errors : 'OK'
  end

  def change_type
    errors = {}
    new_type = params[:new_type]

    old_subset = MenuItem.find(:all, :conditions => ['menu_type = ? AND menu_order > ?', @menu_item.menu_type, @menu_item.menu_order])
    old_subset.each do |item|
      item.menu_order -= 1
      item.save
      errors[item.title] = item.errors if item.errors.any?
    end

    @menu_item.menu_type = new_type
    new_subset = MenuItem.find(:first, :conditions => ['menu_type = ?', new_type], :order => 'menu_order DESC')
    @menu_item.menu_order = new_subset.nil? ? 0 : new_subset.menu_order + 1
    @menu_item.save
    errors[@menu_item.title] = @menu_item.errors if @menu_item.errors.any?

    render :text => errors.any? ? errors : 'OK'
  end

  private
  def get_menu_item
    @menu_item = MenuItem.find(params[:id])
  end
end
