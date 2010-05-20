class BlocksController < ApplicationController
  before_filter :authenticate_author!, :except => :show
  before_filter :get_block, :only => [:show, :edit, :update, :destroy, :change_order, :change_type]

  respond_to :html

  # GET /blocks
  # GET /blocks.xml
  def index
    items = Block.find(:all, :order => 'block_order ASC')
    @blocks = {}
    items.each do |item|
      sype = item.block_type.to_sym
      @blocks[sype] = [] if @blocks[sype].nil?
      @blocks[sype] << item
    end

    respond_with @blocks
  end

  # GET /blocks/new
  # GET /blocks/new.xml
  def new
    @block = Block.new
    respond_with @block
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.xml
  def create
    @block = Block.new(params[:block])
    fb = Block.find(:first, :conditions => ['block_type = ?', @block.block_type], :order => 'block_order DESC')
    @block.block_order = fb.nil? ? 0 : fb.block_order + 1

    if @block.save
      flash[:notice] = t(:notice, :scope => [:blocks, :create])
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # PUT /blocks/1
  # PUT /blocks/1.xml
  def update
    if @block.update_attributes params[:block]
      flash[:notice] = t(:notice, :scope => [:blocks, :update])
      redirect_to :action => :index
    else
      render :action => :edit
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.xml
  def destroy
    @block.destroy

    redirect_to blocks_url
  end

  def change_order
    errors = {}
    old_pos = @block.menu_order
    new_pos = params[:new_pos].to_i

    subset = Block.find(:all, :conditions => ['block_type = ?', @block.menu_type], :order => 'block_order ASC')
    subset[(old_pos + 1)..new_pos].each { |item| item.block_order -= 1 } if new_pos > old_pos
    subset[new_pos..(old_pos - 1)].each { |item| item.block_order += 1 } if new_pos < old_pos
    @block.block_order = new_pos
    subset.each do |item|
      item.save
      errors[item.title] = item.errors if item.errors.any?
    end
    @block.save
    errors[@block.title] = @block.errors if @block.errors.any?

    render :text => errors.any? ? errors : 'OK'
  end

  def change_type
    errors = {}
    new_type = params[:new_type]
    old_subset = Block.find(:all, :conditions => ['block_type = ? AND block_order > ?', @block.block_type, @block.block_order])
    old_subset.each do |item|
      item.block_order -= 1
      item.save
      errors[item.title] = item.errors if item.errors.any?
    end

    @block.block_type = block_type
    new_subset = Block.find(:first, :conditions => ['block_type = ?', new_type], :order => 'block_order DESC')
    @block.menu_order = new_subset.nil? ? 0 : new_subset.menu_order + 1
    @block.save
    errors[@block.title] = @block.errors if @block.errors.any?

    render :text => errors.any? ? errors : 'OK'
  end

  private
  def get_block
    @block = Block.find params[:id]
  end
end
