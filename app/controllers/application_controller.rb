class ApplicationController < ActionController::Base

  helper :all
  protect_from_forgery
  layout 'application'
  before_filter :set_locale, :get_tags

  def default_url_options(options={})
    {:locale => I18n.locale}
  end

  def set_locale
    @available_locales = available_locales
    locale = params[:locale]
    locale ||= request.preferred_language_from(@available_locales.keys)
    I18n.locale = locale if @available_locales.has_key? locale
  end

  def available_locales
    AVAILABLE_LOCALES
  end

  def error(code)
    render :file => "#{RAILS_ROOT}/public/#{code.to_s}.html", :status => code
  end

  private
  def get_tags
    @tags = Tag.find(:all, :limit => 20, :order => "label_#{I18n.locale} asc")
  end
end
