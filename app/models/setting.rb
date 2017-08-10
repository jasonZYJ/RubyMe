# RailsSettings Model
class Setting < RailsSettings::Base
  source Rails.root.join('config/config.yml')

  #TODO has 2 gems about setting, need to refactor
  # List setting value separator chars
  SEPARATOR_REGEXP = /[\s,]/

  # keys that allow update in admin
  KEYS_IN_ADMIN = %w(
    custom_head_html
    navbar_html
    navbar_brand_html
    footer_html
    index_html
    wiki_index_html
    wiki_sidebar_html
    site_index_html
    post_index_sidebar_html
    after_post_html
    before_post_html
    node_ids_hide_in_posts_index
    reject_newbie_reply_in_the_evening
    newbie_limit_time
    ban_words_on_reply
    newbie_notices
    tips
    apns_pem
    blacklist_ips
    admin_emails
  )

  class << self
    def protocol
      self.https ? 'https' : 'http'
    end

    def base_url
      [self.protocol, self.domain].join('://')
    end

    def has_admin?(email)
      return false if self.admin_emails.blank?
      self.admin_emails.split(SEPARATOR_REGEXP).include?(email)
    end

    %w(module profile_field).each do |field|
      define_method("has_#{field}?") do |name|
        return true if self.send(name.pluralize).blank? || self.send(name.pluralize) == 'all'
        self.send(name.pluralize).split(SEPARATOR_REGEXP).include?(name.to_s)
      end
    end

    def sso_enabled?
      return false if self.sso_provider_enabled?
      self.sso['enable']
    end

    def sso_provider_enabled?
      self.sso['enable_provider']
    end
  end
end
