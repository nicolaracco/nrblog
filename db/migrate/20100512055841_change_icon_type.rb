class ChangeIconType < ActiveRecord::Migration
  def self.up
    remove_column :contents, :icon_file_name
    remove_column :contents, :icon_content_type
    remove_column :contents, :icon_content_size
    remove_column :contents, :icon_updated_at

    add_column :contents, :image_id, :integer
  end

  def self.down
  end
end
