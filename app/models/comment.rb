class Comment < ActiveRecord::Base
  belongs_to :content

  validates_presence_of :content_id, :user_name, :user_email, :body
  validates_format_of :user_email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  cattr_reader :per_page
  @@per_page = 3
end
