module BlocksHelper
  def published_contents
    Content.find(:all, :conditions => 'published = 1')
  end

  def available_block_types
    return [ :left_side ]
  end

  def available_left_side_blocks
    Block.find(:all, :conditions => 'block_type = \'left_side\'', :order => 'block_order ASC')
  end
end
