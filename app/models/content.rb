class Content < ActiveRecord::Base
  include Paperclip
  validates_uniqueness_of :url_alias
  validates_presence_of :url_alias, :title_it, :title_en, :content_it, :content_en, :author_id, :category_id

  belongs_to :author
  belongs_to :category
  belongs_to :image
  has_and_belongs_to_many :tags
  has_many :attachments
  has_many :comments

  translatable_columns :title, :content, :summary

  def attachments_toadd=(attachment_attributes)
    attachment_attributes.each do |attributes|
      attachments.build({ 'file' => attributes[1]})
    end
  end

  def tags_list
    ret = []
    tags.each { |x| ret << x.label }
    ret.join ', '
  end

  def tags_list= list
    tags.destroy_all
    array = list.split ','
    array.each { |x| tags << Tag.find_or_create(x.strip) }
  end
end
