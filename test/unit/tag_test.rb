require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "not save tag without url_alias and labels" do
    tag = Tag.new()
    assert !tag.save
  end
  test "not save tag without labels" do
    tag = Tag.new({:url_alias => 'onlyalias'})
    assert !tag.save
  end
  test "save tag generating fields when only a label is provided" do
    tag = Tag.new({:label_en => 'OnlyLabel Tag'})
    assert tag.save
    assert tag.label_en == tag.label_it, "#{tag.label_en} != #{tag.label_it}"
    assert tag.url_alias == 'onlylabel_tag', "#{tag.url_alias}"
  end
  test "check unique fields" do
    tag = Tag.new({:label_it => 'testunique', :label_en => 'uniquetest', :url_alias => 'ualias'})
    assert tag.save
    tag = Tag.new({:label_it => 'testunique', :label_en => 'asa', :url_alias => 'asalias'})
    assert !tag.save
    tag.label_it, tag.label_en = tag.label_en, 'uniquetest'
    assert !tag.save
    tag.label_en, tag.url_alias = tag.label_it, 'ualias'
    assert !tag.save
    tag.label_it, tag.label_en, tag.url_alias = 'uniquetest', 'testunique', 'asalias'
    otag = Tag.find(:first, :conditions => ['label_en like ?', tag.label_it])
    assert !otag.nil? && otag.label_en == tag.label_it && !tag.save, "Problem in check_label_between_locales using #{otag} and otag.label_en(#{otag.label_en}), tag.label_it(#{tag.label_it})"
  end
  test "find or create tag by label" do
    tag = Tag.find_or_create 'findlabel'
    assert !tag.nil?
    tag2 = Tag.find_or_create 'findlabel'
    assert !tag2.nil?
    assert tag.id == tag2.id
  end
end
