class Image < ActiveRecord::Base
  include Paperclip

  translatable_columns :title
  has_attached_file :content, :styles => { :thumb => ['64x64>'] }

  validates_presence_of :title_en, :title_it, :url_alias
  validates_attachment_presence :content
  validates_attachment_content_type :content, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/ico']
  validates_uniqueness_of :url_alias

  def url type=nil
    content.url type
  end
end
