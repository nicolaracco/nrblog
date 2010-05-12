class AddNameToTag < ActiveRecord::Migration
  def self.up
    add_column :tags, :url_alias, :string
  end

  def self.down
  end
end
