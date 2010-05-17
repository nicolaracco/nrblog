module MenuItemsHelper
  def available_menu_types
    return [ :horizontal_top, :vertical_right ]
  end

  def enabled_top_horizontal_menu_items
    return MenuItem.find :all, :conditions => 'menu_type = \'horizontal_top\''
  end

  def enabled_vertical_right_menu_items
    return MenuItem.find :all, :conditions => 'menu_type = \'vertical_right\''
  end
end
