class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :title_en, :null => false
      t.string :title_it, :null => false
      t.integer :author_id, :null => false
      t.string :url_alias, :null => false
      t.text :content_it, :null => false
      t.text :content_en, :null => false
      t.text :summary_it
      t.text :summary_en
      t.integer :category_id, :null => false
      t.boolean :published
      t.boolean :has_comments
      t.boolean :in_home

      t.string :icon_file_name
      t.string :icon_content_type
      t.integer :icon_content_size
      t.datetime :icon_updated_at

      t.timestamps
    end
    add_index :contents, :category_id
    add_index :contents, :author_id
    add_index :contents, :url_alias, :unique => true
  end

  def self.down
    drop_table :contents
  end
end
