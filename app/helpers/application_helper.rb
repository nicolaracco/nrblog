module ApplicationHelper
  def refresh_link
    link_to t(:refresh_layout), 'javascript:location.reload(true);'
  end

  def remove_icon
    image_tag '/_images_/remove-icon.png', :alt => t(:link_destroy), :title => t(:link_destroy)
  end

  def edit_icon
    image_tag '/_images_/edit-icon.png', :alt => t(:link_edit), :title => t(:link_edit)
  end

  def tag_cloud(tags, classes)
    max, min = 0, 0
    tags.each do |t|
      max = t.contents.length if t.contents.length > max
      min = t.contents.length if t.contents.length < min
    end

    divisor = ((max - min) / classes.size) + 1

    tags.each { |t| yield t.label, t.url_alias, classes[(t.contents.length - min) / divisor] }
  end

  def localized_uri(lang_code)
    dms = request.fullpath.split('/').delete_if { |l| l.blank? }
    if @available_locales.keys.include? dms[0]
      dms[0] = lang_code
    else
      dms = [lang_code] + dms
    end
    'http://' + request.host + '/' + dms.join('/')
  end
end
