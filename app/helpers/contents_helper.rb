module ContentsHelper
  def content_to_html content
    redcloth(highlight content)
  end

  private
  def redcloth content
    RedCloth.new(content).to_html
  end

  def highlight content
    Highlighter.highlight content
  end
end
