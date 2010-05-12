class Attachment < ActiveRecord::Base
  include Paperclip

  belongs_to :content

  has_attached_file :file
  validates_attachment_presence :file
end
