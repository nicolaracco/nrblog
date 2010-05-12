class Category < ActiveRecord::Base
  translatable_columns :label
  validates_presence_of :label_en, :label_it, :url_alias
  validates_uniqueness_of :url_alias

  has_many :contents

  def url
    '/content/' + self.url_alias
  end

  def to_s
    self.label
  end
end
