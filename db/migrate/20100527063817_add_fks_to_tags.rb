class AddFksToTags < ActiveRecord::Migration
  class ContentsTag < ActiveRecord::Base
  end

  def self.up
    dict = self.contents_to_dict
    drop_table :contents_tags
    create_table :contents_tags, :id => false do |t|
      t.references :tag
      t.references :content
    end
    add_index :contents_tags, [:tag_id, :content_id], :unique => true

    self.dict_to_contents dict
  end

  def self.contents_to_dict
    tags = ContentsTag.find :all
    dict = {}
    tags.each do |c| 
      dict[c.content_id] ||= []
      dict[c.content_id] << c.tag_id
    end
    return dict
  end

  def self.dict_to_contents dict
    dict.each do |key, values|
      values.each do |tag_id|
        item = ContentsTag.new
        item.tag_id, item.content_id = tag_id, key
        item.save()
      end
    end
  end

  def self.down
    dict = self.contents_to_dict
    drop_table :contents_tags
    create_table :contents_tags do |t|
      t.integer :content_id, :null => false
      t.integer :tag_id, :null => false
    end
    add_index :contents_tags, [:tag_id, :content_id], :unique => true
    self.dict_to_contents dict
  end
end
