Rails.application.config.assets.precompile += Ckeditor.assets

Rails.application.config.assets.precompile += %w(
  home.css frontend/blogger.css
  session.css
)

Rails.application.config.assets.precompile += %w(
  shared/ie_support.js
  home.js frontend/blogger.js
  session.js shared/highlight.js
)
