class MenuItem < ActiveRecord::Base
  translatable_columns :title
  validates_presence_of :title_it, :title_en, :menu_type, :url
  before_validate :fill_empty_i18n, :strip_fields

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
end
