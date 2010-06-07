require 'test_helper'

class MenuItemTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Cannot save menu_item without required fields" do
    mi = MenuItem.new
    assert !mi.save
  end
  test "Generate title and order on save" do
    mi = MenuItem.new({:title_it => 'Due menu', :url => 'testaddress', :menu_type => 'horizontal_top' })
    assert mi.save
  end
end
