require 'test_helper'

class BlockTest < ActiveSupport::TestCase
  test "Cannot save without required fields" do
    bl = Block.new
    assert !bl.save
  end
  test "Generate title and order on save" do
    bl = Block.new({:title_it => 'Due block', :block_type => 'left_side' })
    bl.content = contents(:one)
    assert bl.save
  end
end
