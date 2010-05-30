class ChangeCodeTagStyle < ActiveRecord::Migration
  def self.up
    contents = Content.find :all
    contents.each do |content|
      content.content_it = replace_content content.content_it
      content.content_en = replace_content content.content_en
      content.save
    end
  end

  def self.replace_content text
    text.gsub(/^(\s*)code\((\w+)\)\.\s*$/) { |block| block = "#{$1}bc[#{$2}]." }
  end

  def self.down
  end
end
