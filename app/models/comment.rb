class Comment < ActiveRecord::Base
  belongs_to :content

  validates_presence_of :content_id, :user_name, :user_email, :body
end
