RuCaptcha.configure do
  # Number of chars, default: 4
  self.len = 4
  # Image font size, default: 45
  self.font_size = 45
  # Cache generated images in file store, this is config files limit, default: 100
  # set 0 to disable file cache.
  self.cache_limit = 100
  # 文字扭曲度，调整这个可以提高阅读难度，默认 0.4 范围 [0.0 - 1.0]
  self.implode = 0.2
end