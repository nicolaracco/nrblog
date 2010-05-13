class Block < ActiveRecord::Base
  translatable_columns :title
  validates_presence_of :title_it, :title_en, :content_id, :block_type
  belongs_to :content
  before_validation :fill_empty_i18n, :strip_fields

  private
  def strip_fields
    self.title_it = self.title_it.strip unless self.title_it.nil?
    self.title_en = self.title_en.strip unless self.title_en.nil?
  end

  def fill_empty_i18n
    if self.title_it.blank? && !self.title_en.blank?
      self.title_it = self.title_en
    elsif self.title_en.blank? && !self.title_it.blank?
      self.title_en = self.title_it
    end
  end
end
