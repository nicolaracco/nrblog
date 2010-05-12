class CreateMenuItems < ActiveRecord::Migration
  def self.up
    create_table :menu_items do |t|
      t.string :menu_type
      t.string :title_en
      t.string :title_it
      t.string :url
      t.integer :menu_order

      t.timestamps
    end
  end

  def self.down
    drop_table :menu_items
  end
end
