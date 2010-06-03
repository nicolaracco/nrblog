require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "not save category without required fields" do
    cat = Category.new
    assert !cat.save
  end
  test "save category using url_alias and only a label" do
    cat = Category.new({:label_it => 'test', :url_alias => 'test'})
    assert cat.save
  end
  test "check uniqueness" do
    ocat = Category.new({:label_it => 'test', :url_alias => 'test'})
    assert ocat.save
    cat = Category.new({:label_it => 'test', :label_en => 'othertest', :url_alias => 'otheralias'})
    assert !cat.save, "#{ocat.label_it} != #{cat.label_it}"
    cat.label_it, cat.label_en = cat.label_en, cat.label_it
    assert !cat.save
    cat.label_en, cat.url_alias = cat.label_it, cat.label_en
    assert !cat.save
    cat.url_alias = 'otheralias'
    assert cat.save
  end
  test "check reserved words in url_alias" do
    words = %w(404.html 422.html 500.html favicon.ico _images_ javascripts _markitup_ robots.txt stylesheets system)
    cat = Category.new({:label_it => 'myotest'})
    words.each do |wrd|
      cat.url_alias = wrd
      assert !cat.save
    end
  end
end
