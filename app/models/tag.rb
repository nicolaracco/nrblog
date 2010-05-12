class Tag < ActiveRecord::Base
  translatable_columns :label
  before_save :check_empty_label
  validates :label_it, :presence => true, :uniqueness => true, :tag_name => true
  validates :label_en, :presence => true, :uniqueness => true, :tag_name => true
  validates :url_alias, :presence => true, :uniqueness => true
  has_and_belongs_to_many :contents

  def Tag.find_or_create label
    tag = Tag.find(:first, :conditions => ['label_it like ? OR label_en like ?', label, label])
    if tag.nil?
      tag = Tag.new
      tag.label_it = tag.label_en = label
      tag.url_alias = label.gsub(/ /,'').downcase
      tag.save
    end
    return tag
  end

  private
  def check_empty_label
    self.label_it = self.label if self.label_it.empty?
    self.label_en = self.label if self.label_en.empty?
  end
end
