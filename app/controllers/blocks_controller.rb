class BlocksController < ApplicationController
  before_filter :authenticate_author!, :except => :show
  before_filter :get_block, :only => [:show, :edit, :update, :destroy]

  respond_to :html

  # GET /blocks
  # GET /blocks.xml
  def index
    respond_with @blocks = Block.all
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
      flash[:notice] = t(:block_created)
      redirect_to :action => :index
    else
      render :action => :new
    end
  end

  # PUT /blocks/1
  # PUT /blocks/1.xml
  def update
    respond_with @block, :notice => t(:block_updated)
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.xml
  def destroy
    @block.destroy

    redirect_to blocks_url
  end

  private
  def get_block
    @block = Block.find params[:id]
  end
end
