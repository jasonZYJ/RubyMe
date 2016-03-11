# coding: utf-8
if ENV['USE_OFFICIAL_GEM_SOURCE']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

gem 'rails', '4.1.5'

gem 'pg', '0.17.1' # Use postgresql as the database for Active Record
gem 'social-share-button'
gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'bootstrap-wysihtml5-rails', '~> 0.3.2.100'
gem 'autoprefixer-rails', '~> 2.2.0'
gem 'font-awesome-rails', '4.1.0'

gem 'rmmseg-cpp', require: false # high performance Chinese word segmentation utility for Ruby

gem 'sass-rails', '~> 4.0.3' # Use SCSS for stylesheets
gem 'uglifier', '~> 2.5.3' # Use Uglifier as compressor for JavaScript assets
gem 'coffee-rails', '~> 4.0.0' # Use CoffeeScript for .js.coffee assets and views
gem 'rails_config', '~> 0.4.2' # 从yml文件加载配置
gem 'kaminari', '~> 0.16.1'
gem 'activeadmin', '~> 1.0.0.pre', github: 'gregbell/active_admin'
gem 'jquery-rails', '~> 3.1.1' # Use jquery as the JavaScript library
gem 'yui-compressor', '~> 0.12.0', require: false #预编译压缩Assets
gem 'turbolinks', '~>2.3.0' # Turbolinks makes following links in your web application faster.
gem 'jbuilder', '~> 2.0' # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'devise', '3.3.0' # 用户session管理
gem 'devise-i18n', '0.11.0' # devise国际化支持
gem 'devise-async', '0.9.0' # 异步处理devise邮件

gem 'friendly_id', '5.0.4' # 更友好的id
gem 'simple_form', '3.1.0.rc2' # 页面表单
gem 'paranoia', '2.0.2' # 软删除
gem 'browser', '0.6.0' # 浏览器版本检测

gem 'bugsnag', '~> 2.4.1' #实时错误检测
gem 'whenever', '~> 0.9.2', require: false #定时任务
gem 'nokogiri', '~> 1.6.3.1', require: false #抓取页面信息
gem 'actionpack-action_caching', '~> 1.1.1'

gem 'rails-i18n', '>= 4.0.2', github: 'svenfuchs/rails-i18n', branch: 'master' # For 4.x 国际化支持

gem 'ckeditor', '~> 4.0.11' #html编辑器
gem 'non-stupid-digest-assets', '~> 1.0.4'
gem 'carrierwave', '~> 0.10.0' #文件上传
gem 'mini_magick', '~> 3.8.0' #图片切割大小
gem 'qiniu-rs', '~> 3.4.10'
gem 'carrierwave-qiniu', '~> 0.1.3'

gem 'daemons', '1.1.9' #支持后台进程
gem 'sidekiq', '3.2.5' #延时任务支持
gem 'sinatra', '1.4.5', require: false # 使用自带的监控页面
gem 'redis-rails', '~> 4.0.0'
gem 'redis-namespace', '~> 1.4.1'
gem 'redis-semaphore', '~> 0.2.2'
gem 'rucaptcha'

gem 'letter_avatar'

gem 'puma', '~> 2.9.1' #多线程支持

# 三方平台 OAuth 验证登陆
gem "omniauth", "~> 1.0.1"
gem "omniauth-github", "~> 1.1.0"

group :production do
  gem 'unicorn', '~> 4.8.3'
end

group :development, :test do
  gem 'byebug', '~> 3.2.0'
  gem 'yard', '~> 0.8.7' # 项目文档
  gem 'better_errors', '1.1.0'
  gem 'binding_of_caller', '0.7.2'
  gem 'quiet_assets'

  gem 'hirb', '0.7.2' #rails c表格化显示

  # for deploy by capistrano
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rvm', '~> 0.1.1'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler', '~> 1.1.3'
  gem 'highline', '~> 1.6.21' #发布时不显示密码

  gem 'capybara', '~> 2.4.3' #页面测试
  gem 'rspec-rails', '~> 3.0.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'jasmine-rails', '~> 0.10.2'
  gem 'watir-webdriver', '~> 0.6.11'
  gem 'rspec-example_steps', '~> 3.0.2'
  gem 'simplecov', '0.9.0', require: false # 测试覆盖率并生成html报告
  gem 'coveralls', '0.7.1', require: false # 测试覆盖率并与travis-ci集成

  gem 'shoulda-matchers', '~> 2.6.2'
  gem 'rspec-expectations', '~> 3.0.0'
  gem 'rails_best_practices', '~> 1.15.4'
end
