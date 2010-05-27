class AddFksToBlock < ActiveRecord::Migration
  class Block < ActiveRecord::Base
  end

  def self.up
    dict = self.contents_to_dict
    change_table :blocks do |t|
      t.remove :content_id

      t.references :content
    end

    self.dict_to_contents dict
  end

  def self.contents_to_dict
    blocks = Block.find :all
    dict = {}
    blocks.each { |c| dict[c.id] = { 'content' => c.content_id } }
    return dict
  end

  def self.dict_to_contents dict
    dict.each do |key, values|
      item = Block.find key
      item.content_id = values['content']
      item.save()
    end
  end

  def self.down
    dict = self.contents_to_dict
    change_table :blocks do |t|
      t.remove :content_id

      t.integer :content_id
    end
    add_index :blocks, :content_id
    self.dict_to_contents dict
  end
end
