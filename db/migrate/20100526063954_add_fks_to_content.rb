class AddFksToContent < ActiveRecord::Migration
  class Content < ActiveRecord::Base
  end

  def self.up
    dict = self.contents_to_dict
    change_table :contents do |t|
      t.remove :category_id
      t.remove :author_id

      t.references :category
      t.references :author
    end

    self.dict_to_contents dict
  end

  def self.contents_to_dict
    contents = Content.find :all
    dict = {}
    contents.each { |c| dict[c.id] = { 'category' => c.category_id, 'author' => c.author_id } }
    return dict
  end

  def self.dict_to_contents dict
    dict.each do |key, values|
      item = Content.find key
      item.category_id, item.author_id = values['category'], values['author']
      item.save()
    end
  end

  def self.down
    dict = self.contents_to_dict
    change_table :contents do |t|
      t.remove :category_id
      t.remove :author_id

      t.integer :author_id
      t.integer :category_id
    end
    add_index :contents, :author_id
    add_index :contents, :category_id
    self.dict_to_contents dict
  end
end
