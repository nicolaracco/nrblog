class Content < ActiveRecord::Base
  include Paperclip
  validates_uniqueness_of :url_alias
  validates_presence_of :url_alias, :title_it, :title_en, :content_it, :content_en, :author_id, :category_id
  validates_length_of :url_alias, :minimum => 3, :maximum => 50
  validates_format_of :url_alias, :with => /\A[a-zA-Z_\-0-9]*\z/
  before_validation :strip_fields

  belongs_to :author
  belongs_to :category
  belongs_to :image
  has_and_belongs_to_many :tags
  has_many :attachments, :dependent => :destroy

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
    #self.tags.destroy_all
    array = list.split ','
    nt = []
    array.each do |x| 
      nt << Tag.find_or_create(x.strip).id
    end
    self.tag_ids = nt
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
