class Content < ActiveRecord::Base
  include Paperclip
  validates_uniqueness_of :url_alias
  validates_presence_of :url_alias, :title_it, :title_en, :content_it, :content_en, :author_id, :category_id
  validates_length_of :url_alias, :minimum => 3, :maximum => 25
  before_validation :strip_fields

  belongs_to :author
  belongs_to :category
  belongs_to :image
  has_and_belongs_to_many :tags
  has_many :attachments
  has_many :comments

  translatable_columns :title, :content, :summary

  cattr_reader :per_page
  @@per_page = 5

  def attachments_toadd=(attachment_attributes)
    attachment_attributes.each do |attributes|
      attachments.build({ 'file' => attributes[1]})
    end
  end

  def tags_list
    ret = []
    self.tags.each { |x| ret << x.label }
    ret.join ', '
  end

  def tags_list= list
    self.tags.destroy_all
    array = list.split ','
    array.each { |x| self.tags << Tag.find_or_create(x.strip) }
  end

  private
  def strip_fields
    self.title_it = self.title_it.strip unless self.title_it.nil?
    self.title_en = self.title_en.strip unless self.title_en.nil?
    self.url_alias = self.url_alias.strip unless self.url_alias.nil?
    self.summary_it = self.summary_it.strip unless self.summary_it.nil?
    self.summary_en = self.summary_en.strip unless self.summary_en.nil?
  end
end
