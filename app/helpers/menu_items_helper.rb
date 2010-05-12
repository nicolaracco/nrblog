module MenuItemsHelper
  def available_menu_types
    return [ :menu_horizontal_top ]
  end

  def enabled_top_horizontal_menu_items
    return MenuItem.find :all, :conditions => 'menu_type = \'menu_horizontal_top\''
  end
end
