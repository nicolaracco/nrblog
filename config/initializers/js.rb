# Switch the javascript_include_tag :defaults to use jquery instead of
# # the default prototype helpers.
if ActionView::Helpers::AssetTagHelper.const_defined?(:JAVASCRIPT_DEFAULT_SOURCES)
  ActionView::Helpers::AssetTagHelper.send(:remove_const, "JAVASCRIPT_DEFAULT_SOURCES")
end
ActionView::Helpers::AssetTagHelper::JAVASCRIPT_DEFAULT_SOURCES = ['jquery-1.4.2', 'jquery.efn', 'jquery-ujs/src/rails', 'jquery.form-2.43.js']
ActionView::Helpers::AssetTagHelper::reset_javascript_include_default

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :jquery_ui => ['jquery-ui-1.8.1.custom.min.js']
ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :jquery_ui => ['cupertino/jquery-ui-1.8.1.custom.css']

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :mark_it_up => ['markitup/jquery.markitup.js', 'markitup/sets/textile/set.js']
ActionView::Helpers::AssetTagHelper.register_stylesheet_expansion :mark_it_up => ['markitup/skins/markitup/style.css', 'markitup/sets/textile/style.css']
