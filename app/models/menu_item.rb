class MenuItem < ActiveRecord::Base
  translatable_columns :title
  validates_presence_of :title_it, :title_en, :menu_type, :url
end
