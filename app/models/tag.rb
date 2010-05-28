class Tag < ActiveRecord::Base
  translatable_columns :label
  validates :label_it, :presence => true, :uniqueness => true
  validates :label_en, :presence => true, :uniqueness => true
  validates :url_alias, :presence => true, :uniqueness => true
  has_and_belongs_to_many :contents
  before_validation :fill_empty_i18n, :strip_fields

  def Tag.find_or_create label
    tag = Tag.find(:first, :conditions => ['label_it like ? OR label_en like ?', label, label])
    if tag.nil?
      tag = Tag.new
      tag.label_it = tag.label_en = label
      tag.url_alias = label.gsub(/ /,'').gsub(/\./,'').downcase
      tag.save
    end
    return tag
  end

  private
  def fill_empty_i18n
    if self.label_it.blank? && !self.label_en.blank?
      self.label_it = self.label_en
    elsif self.label_en.blank? && !self.label_it.blank?
      self.label_en = self.label_it
    end
  end

  def strip_fields
    self.label_it = self.label_it.strip unless self.label_it.nil?
    self.label_en = self.label_en.strip unless self.label_en.nil?
  end
end
