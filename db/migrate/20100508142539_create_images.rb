class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :content_file_name
      t.string :content_content_type
      t.integer :content_file_size
      t.datetime :content_updated_at
      t.string :title_en
      t.string :title_it

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
