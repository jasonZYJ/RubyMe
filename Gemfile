# coding: utf-8
if ENV['USE_OFFICIAL_GEM_SOURCE']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.5'
# Use postgresql as the database for Active Record
gem 'pg'

gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'bootstrap-wysihtml5-rails', '~> 0.3.2.100'
gem 'autoprefixer-rails', '~> 2.2.0'
gem 'font-awesome-sass-rails', '~> 3.0.2.2'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.5.3'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
gem 'rails_config', '~> 0.4.2'  # 从yml文件加载配置
gem 'kaminari', '~> 0.16.1'
gem 'activeadmin', '~> 1.0.0.pre', github: 'gregbell/active_admin'
# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 3.1.1'
gem 'yui-compressor', '~> 0.12.0', require: false
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~>2.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'devise', '3.3.0' # 用户session管理
gem 'devise-i18n', '0.11.0' # devise国际化支持
gem 'devise-async', '0.9.0' # 异步处理devise邮件

gem 'friendly_id', '5.0.4' # 更友好的id
gem 'simple_form', '3.1.0.rc2' # 页面表单
gem 'paranoia', '2.0.2' # 软删除
gem 'browser', '0.6.0' # 浏览器版本检测

gem 'bugsnag', '~> 2.4.1'
gem 'whenever', '~> 0.9.2', require: false
gem 'nokogiri', '~> 1.6.3.1', require: false
gem 'actionpack-action_caching', '~> 1.1.1'

# gem 'country_select', '~> 2.0.0.beta2', github: 'stefanpenner/country_select'
gem 'rails-i18n', '>= 4.0.2', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x

gem 'simple_captcha', '~> 0.1.6', github: 'galetahub/simple-captcha'

gem 'ckeditor', '~> 4.0.11'
gem 'non-stupid-digest-assets', '~> 1.0.4'
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 3.8.0'
gem 'qiniu-rs', '~> 3.4.10'
gem 'carrierwave-qiniu', '~> 0.1.3'

gem 'daemons', '1.1.9'
gem 'sidekiq', '3.2.5'
gem 'sinatra', '1.4.5', require: false # 使用自带的监控页面
gem 'redis-rails', '~> 4.0.0'
gem 'redis-namespace', '~> 1.4.1'
gem 'redis-semaphore', '~> 0.2.2'
# gem 'rack-cache', '~> 1.2'
# gem 'redis-rack-cache', '~> 1.2.2'

gem 'puma', '~> 2.9.1'

group :production do
  gem 'unicorn', '~> 4.8.3'
end

group :development, :test do
  gem 'byebug', '~> 3.2.0'
  gem 'better_errors', '1.1.0'
  gem 'binding_of_caller', '0.7.2'

  gem 'hirb', '0.7.2'
  # gem 'better_errors', '~> 1.1.0'
  # gem 'binding_of_caller', '~> 0.7.2'

  # for deploy by capistrano
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'highline', '~> 1.6.21'
  gem 'capybara', '~> 2.4.3'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'jasmine-rails', '~> 0.10.2'
  gem 'watir-webdriver', '~> 0.6.11'
  gem 'rspec-example_steps', '~> 3.0.2'
# gem 'coco', '~> 0.12.0'
  gem 'simplecov', '0.9.0', require: false # 测试覆盖率并生成html报告
  # gem 'coveralls', '0.7.1', require: false # 测试覆盖率并上传到coveralls.io

  gem 'shoulda-matchers', '~> 2.6.2'
  gem 'rspec-expectations', '~> 3.0.0'
  gem 'rails_best_practices', '~> 1.15.4'
end
