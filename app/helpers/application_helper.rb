module ApplicationHelper


  def gravatar_url(email)
    email_md5 = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{email_md5}?s=120"
    # "http://jasonblog.qiniudn.com/avatar/#{email_md5}.jpg"
  end

  def default_title
    "#{controller_name}/#{action_name}"
  end

  def page_title_tag(action_title=nil)
    "<title>#{Settings.site_name}(#{Settings.site_name_zh}) - #{action_title || default_title}</title>".html_safe
  end

  def omited_str(str, length=60)
    str.truncate(length, separator: ' ', omission: '...')
  end

end
