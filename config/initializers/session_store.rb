# Be sure to restart your server when you modify this file.

# Rails.application.config.session_store :cookie_store, key: '_ruby_me_session'
RubyMe::Application.config.session_store :redis_store
