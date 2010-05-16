module ApplicationHelper
  def tag_cloud(tags, classes)
    max, min = 0, 0
    tags.each do |t|
      max = t.contents.length if t.contents.length > max
      min = t.contents.length if t.contents.length < min
    end

    divisor = ((max - min) / classes.size) + 1

    tags.each { |t| yield t.label, classes[(t.contents.length - min) / divisor] }
  end

  def localized_uri(lang_code)
    if lang_code == 'en'
      lang_code = 'com'
    end
    dms = request.host.split '.'
    'http://' + (dms[0, dms.length - 1] << lang_code).join('.') + request.fullpath
  end
end
