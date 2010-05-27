class AddFksToContent2 < ActiveRecord::Migration
  class Content < ActiveRecord::Base
  end

  def self.up
    dict = self.contents_to_dict
    change_table :contents do |t|
      t.remove :image_id

      t.references :image
    end

    self.dict_to_contents dict
  end

  def self.contents_to_dict
    contents = Content.find :all
    dict = {}
    contents.each { |c| dict[c.id] = { 'image' => c.image_id } }
    return dict
  end

  def self.dict_to_contents dict
    dict.each do |key, values|
      item = Content.find key
      item.image_id = values['image']
      item.save()
    end
  end

  def self.down
    dict = self.contents_to_dict
    change_table :contents do |t|
      t.remove :image_id

      t.integer :image_id
    end
    add_index :contents, :image_id
    self.dict_to_contents dict
  end
end
