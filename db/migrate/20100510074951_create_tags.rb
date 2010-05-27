class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string :url_alias, :null => false
      t.string :label_it, :null => false
      t.string :label_en, :null => false
    end
    add_index :tags, :label_it, :unique => true
    add_index :tags, :label_en, :unique => true

    create_table :contents_tags, :id => false do |t|
      t.integer :tag_id, :null => false
      t.integer :content_id, :null => false
    end
    add_index :contents_tags, [:tag_id, :content_id], :unique => true
  end

  def self.down
    drop_table :tags
    drop_table :contents_tags
  end
end
