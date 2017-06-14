# coding: utf-8

source 'https://gems.ruby-china.org/'

gem 'rails', '4.2.1'

gem 'pg' # Use postgresql as the database for Active Record
gem 'social-share-button'
gem 'bootstrap-sass'
gem 'bootstrap-wysihtml5-rails'
gem 'autoprefixer-rails'
gem 'font-awesome-rails'

gem 'rmmseg-cpp', require: false # high performance Chinese word segmentation utility for Ruby

gem 'sass-rails' # Use SCSS for stylesheets
gem 'uglifier' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails' # Use CoffeeScript for .js.coffee assets and views
gem 'config' # 从yml文件加载配置
gem 'kaminari'
gem 'activeadmin', git: "https://github.com/gregbell/active_admin"
gem 'jquery-rails' # Use jquery as the JavaScript library
gem 'yui-compressor', require: false #预编译压缩Assets
gem 'turbolinks' # Turbolinks makes following links in your web application faster.
gem 'jquery-turbolinks'
gem 'jbuilder' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'climate_control'

gem 'status-page'

gem 'devise' # 用户session管理
gem 'devise-i18n' # devise国际化支持
gem 'devise-async' # 异步处理devise邮件

gem 'gritter'

gem 'friendly_id' # 更友好的id
gem 'simple_form' # 页面表单
gem 'paranoia' # 软删除
gem 'browser' # 浏览器版本检测

gem 'bugsnag' #实时错误检测
gem 'whenever', require: false #定时任务
gem 'nokogiri', require: false #抓取页面信息
gem 'actionpack-action_caching'

gem 'rails-i18n', '~>4.0.2' # For 4.x 国际化支持
gem 'http_accept_language' #detect the users preferred language, as sent by the "Accept-Language" HTTP header

gem 'ckeditor' #html编辑器
gem 'non-stupid-digest-assets'
gem 'carrierwave' #文件上传
gem 'mini_magick' #图片切割大小
gem 'qiniu-rs'
gem 'carrierwave-qiniu'

gem 'daemons' #支持后台进程
gem 'sidekiq' #延时任务支持
gem 'sinatra', require: false # 使用自带的监控页面
gem 'redis-rails'
gem 'redis-namespace'
gem 'redis-semaphore'
gem 'rucaptcha'
gem 'exception-track' #TODO only admin can see this exception-track page and besides

gem 'letter_avatar'

# Permission
gem 'cancancan'

gem 'puma', '2.9.1' #多线程支持      #TODO need to handle higher version non-compatible issue

# 三方平台 OAuth 验证登陆
gem 'omniauth'
gem 'omniauth-github'

group :production do
  gem 'unicorn'
end

group :development, :test do
  gem 'byebug'
  gem 'yard' # 项目文档,for local,localhost:8808 then we can see it
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'

  gem 'hirb' #rails c表格化显示

  # for deploy by capistrano
  gem 'capistrano'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'highline' #发布时不显示密码

  gem 'capybara' #页面测试
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'jasmine-rails'
  gem 'watir-webdriver'
  gem 'rspec-example_steps'
  gem 'simplecov', require: false # 测试覆盖率并生成html报告
  gem 'coveralls', require: false # 测试覆盖率并与travis-ci集成

  gem 'shoulda-matchers'
  gem 'rspec-expectations'
  gem 'rails_best_practices'
end
