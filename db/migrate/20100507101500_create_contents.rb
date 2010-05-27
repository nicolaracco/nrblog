class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.string :title_en, :null => false
      t.string :title_it, :null => false
      t.references :author, :null => false
      t.string :url_alias, :null => false
      t.text :content_it, :null => false
      t.text :content_en, :null => false
      t.text :summary_it
      t.text :summary_en
      t.references :category, :null => false
      t.boolean :published
      t.boolean :has_comments
      t.boolean :in_home
      t.references :image

      t.timestamps
    end
    add_index :contents, :url_alias, :unique => true
  end

  def self.down
    drop_table :contents
  end
end
