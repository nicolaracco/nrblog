require 'http_accept_language'

LOCALES_DIRECTORY = "#{Rails.root}/config/locales/"
AVAILABLE_LOCALES =
  Dir.new(LOCALES_DIRECTORY).entries.collect do |x|
    x =~ /\.yml/ ? x.sub(/\.yml/,'') : nil
  end.compact.each_with_object({}) do |str, hsh|
    begin
      hsh[str] = YAML.load_file(LOCALES_DIRECTORY + str + '.yml')[str]['this_file_language']
    rescue
    end
  end.freeze
Rails.logger.debug "* Loaded locales #{AVAILABLE_LOCALES.inspect}"

Dir.glob("#{LOCALES_DIRECTORY}*.yml").each do |file|
  I18n.load_path << file
end
