# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_blog_me_session'
BlogMe::Application.config.session_store :redis_store
