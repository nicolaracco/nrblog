class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  layout 'application'
  before_filter :set_locale, :get_tags

  def set_locale
    I18n.locale = extract_locale_from_tld
    @available_locales = available_locales
  end

  def available_locales
    AVAILABLE_LOCALES
  end

  def error(code)
    render :file => "#{RAILS_ROOT}/public/#{code.to_s}.html", :status => code
  end

  private
  def extract_locale_from_tld
    parsed_locale = request.host.split('.').last
    parsed_locale = 'en' if parsed_locale == 'com'
    (available_locales.include? parsed_locale) ? parsed_locale : nil
  end

  def get_tags
    @tags = Tag.find(:all, :limit => 20, :order => "label_#{I18n.locale} desc")
  end
end
