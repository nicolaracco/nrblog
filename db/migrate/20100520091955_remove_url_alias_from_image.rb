class RemoveUrlAliasFromImage < ActiveRecord::Migration
  def self.up
    remove_column :images, :url_alias
  end

  def self.down
  end
end
