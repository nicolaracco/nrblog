module FeedHelper
  def feed_icon url
    link_to image_tag('/_images_/feed.jpg', :alt => 'RSS Feed', :title => 'RSS Feed'), url
  end
end
