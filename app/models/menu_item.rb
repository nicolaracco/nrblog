class MenuItem < ActiveRecord::Base
  translatable_columns :title
  validates_presence_of :title_it, :title_en, :menu_type, :url, :menu_order
  before_validation :fill_empty_i18n, :strip_fields, :set_default_position
  validates_inclusion_of :menu_type, :in => %w(horizontal_top vertical_right)
  validates_numericality_of :menu_order

  private
  def strip_fields
    self.title_it = self.title_it.strip unless self.title_it.nil?
    self.title_en = self.title_en.strip unless self.title_en.nil?
    self.url = self.url.strip unless self.url.nil?
  end
  
  def fill_empty_i18n
    if self.title_it.blank? && !self.title_en.blank?
      self.title_it = self.title_en
    elsif self.title_en.blank? && !self.title_it.blank?
      self.title_en = self.title_it
    end
  end

  def set_default_position
    if self.menu_order.nil?
      fb = MenuItem.find(:first, :conditions => ['menu_type = ?', self.menu_type], :order => 'menu_order DESC')
      self.menu_order = fb.nil? ? 0 : fb.menu_order + 1
    end
  end
end
