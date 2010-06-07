require 'test_helper'

class ContentTest < ActiveSupport::TestCase
  test "Cannot save content without required fields" do
    c = Content.new
    assert !c.save
    c.category = categories(:one)
    assert !c.save
    c.url_alias = 'testcontent'
    assert !c.save
    c.author = authors(:guest)
    assert !c.save
    c.title_it = 'Titolo Test'
    assert !c.save
    c.summary_it = 'Sommario Test'
    assert !c.save
    c.content_it = 'Contenuto Test'
    assert !c.save
    c.title_en = 'Test Title'
    assert !c.save
    c.summary_en = 'Test Summary'
    assert !c.save
    c.content_en = 'Test Content'
    assert c.save
  end
  test "Automatically search and apply a new taglist" do
    c = contents(:one)
    c.tags_list = 'test1, test2, test3'
    assert c.save
    assert c.tags.size == 3
  end
end
