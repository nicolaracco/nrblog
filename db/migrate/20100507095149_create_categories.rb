class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :label_it, :null => false
      t.string :label_en, :null => false
      t.string :url_alias, :null => false

      t.timestamps
    end
    add_index :categories, :url_alias, :unique => true
  end

  def self.down
    drop_table :categories
  end
end
