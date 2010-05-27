class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.string :block_type
      t.string :title_en
      t.string :title_it
      t.references :content
      t.boolean :show_title
      t.integer :block_order

      t.timestamps
    end
  end

  def self.down
    drop_table :blocks
  end
end
