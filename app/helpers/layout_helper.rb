module LayoutHelper
  def title(page_title, show_title=true)
    @_content_for[:title] = page_title.to_s
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def js(*args)
    content_for(:head) { javascript_include_tag *args }
  end

  def css(*args)
    content_for(:head) { stylesheet_link_tag *args }
  end
end
