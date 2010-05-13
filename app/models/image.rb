class Image < ActiveRecord::Base
  include Paperclip

  translatable_columns :title
  has_attached_file :content, :styles => { :thumb => ['64x64>'] }

  validates_presence_of :title_en, :title_it, :url_alias
  validates_attachment_presence :content
  validates_attachment_content_type :content, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/ico']
  validates_uniqueness_of :url_alias
  before_validation :fill_empty_i18n, :strip_fields

  def url type=nil
    self.content.url type
  end

  private
  def fill_empty_i18n
    if self.title_it.blank? && !self.title_en.blank?
      self.title_it = self.title_en
    elsif self.title_en.blank? && !self.title_it.blank?
      self.title_en = self.title_it
    end
  end

  def strip_fields
    self.title_it = self.title_it.strip unless self.title_it.nil?
    self.title_en = self.title_en.strip unless self.title_en.nil?
  end
end
