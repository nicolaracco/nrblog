class Block < ActiveRecord::Base
  translatable_columns :title
  validates_presence_of :title_it, :title_en, :content_id, :block_type
  belongs_to :content
end
