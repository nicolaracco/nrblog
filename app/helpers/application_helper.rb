module ApplicationHelper
  def localized_uri(lang_code)
    if lang_code == 'en'
      lang_code = 'com'
    end
    dms = request.host.split '.'
    'http://' + (dms[0, dms.length - 1] << lang_code).join('.') + request.fullpath
  end
end
