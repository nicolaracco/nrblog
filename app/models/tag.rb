class Tag < ActiveRecord::Base
  translatable_columns :label
  validates :label_it, :presence => true, :uniqueness => true
  validates :label_en, :presence => true, :uniqueness => true
  validates :url_alias, :presence => true, :uniqueness => true
  validate :unique_labels_between_locales
  has_and_belongs_to_many :contents
  before_validation :fill_empty_i18n, :strip_fields, :generate_url_alias

  def Tag.find_or_create label
    tag = Tag.find(:first, :conditions => ['label_it like ? OR label_en like ?', label, label])
    if tag.nil?
      tag = Tag.new
      tag.label = label
      tag.save
    end
    return tag
  end

  private
  def unique_labels_between_locales
    if self.id.nil?
      tag = Tag.find :first, :conditions => ['label_it like ?', self.label_en]
    else
      tag = Tag.find :first, :conditions => ['label_it like ? AND id != ?', self.label_en, self.id]
    end
    self.errors.add(:label_en, I18n.t('errors.messages.unique_label_between_locales')) unless tag.nil?
    if self.id.nil?
      tag = Tag.find :first, :conditions => ['label_en like ?', self.label_it]
    else
      tag = Tag.find :first, :conditions => ['label_en like ? AND id != ?', self.label_it, self.id]
    end
    self.errors.add(:label_it, I18n.t('errors.messages.unique_label_between_locales')) unless tag.nil?
  end

  def generate_url_alias
    if self.url_alias.blank? && !self.label.blank?
      self.url_alias = label.gsub(/ /, '_').gsub(/\./,'_').downcase
    end
  end

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
