class Category < ActiveRecord::Base
  translatable_columns :label
  validates_presence_of :label_en, :label_it, :url_alias
  validates_uniqueness_of :url_alias
  before_validation :fill_empty_i18n, :strip_fields
  validates_length_of :url_alias, :minimum => 3, :maximum => 25

  has_many :contents

  def to_s
    self.label
  end

  private
  def strip_fields
    self.label_en = self.label_en.strip unless self.label_en.nil?
    self.label_it = self.label_it.strip unless self.label_it.nil?
    self.url_alias = self.url_alias.strip unless self.url_alias.nil?
  end

  def fill_empty_i18n
    if self.label_en.blank? && !self.label_it.blank?
      self.label_en = self.label_it
    elsif self.label_it.blank? && !self.label_en.blank?
      self.label_it = self.label_en
    end
  end
end
