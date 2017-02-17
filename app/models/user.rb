# encoding: utf-8
require 'open-uri'
require 'file_size_validator'
class User < ActiveRecord::Base
  include LetterAvatar::AvatarHelper

  extend FriendlyId
  friendly_id :uid, use: :finders

  mount_uploader :avatar, UserAvatarUploader

  #Association
  has_many :messages, dependent: :destroy, foreign_key: :user_id
  has_many :posts, dependent: :destroy
  has_many :codes, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_one :postgresql_search, as: :searchable

  #Callback
  before_create :update_ranking
  before_create :init_name, if: Proc.new { |u| u.name.blank? }
  # after_create :init_avatar #TODO No need to init avatar!!
  after_create :send_welcome_mail
  after_create :create_default_category

  attr_accessor :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable, :async,
         authentication_keys: [:login]

  #Validate
  validates :ranking, uniqueness: true
  validates :city_name, allow_blank: true, length: {minimum: 2}
  validates :avatar, file_size: {maximum: 1.megabytes.to_i}, on: [:update] #, if: Proc.new { |u| u.avatar_changed? }

  validates :uid, presence: true, allow_blank: false, uniqueness: {case_sensitive: true},
            length: {minimum: 3, maximum: 24}, exclusion: {in: Settings.exclusions},
            :format => {:with => /\A\w+\z/, :message => '只允许数字、大小写字母和下划线'}
  # validates :avatar, presence: true, file_size: {
  #   minimum: 3.kilobytes.to_i, maximum: 1.megabytes.to_i }
  validates :email, presence: true, allow_blank: false, uniqueness: {case_sensitive: false},
            format: {with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'Email格式不正确'}

  after_save :update_index

  class << self
    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if (login = conditions.delete(:login))
        where(conditions).where(["uid = :value OR email = :value", {value: login}]).first
      else
        where(conditions).first
      end
    end
  end

  def update_index
    if self.login_changed? || self.name_changed?
      SearchIndexerWorker.perform_async('user', self.id)
    end
  end

  def to_search_data
    %Q(#{self.login} #{self.name})
  end

  def human_name
    self.uid
  end

  def whose_blogger
    %Q(#{self.uid} 的博客)
  end

  def created_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def github_page
    %Q(https://github.com/#{self.github})
  end

  def city
    self.city_name || '未知'
  end

  def blogger_title
    self.signature || self.whose_blogger
  end

  def avatar_url(size, version=nil)
    if self.avatar? && self.avatar.versions.keys.include?(version.try(:to_sym))
      self.avatar.send(version).url
    else
      width = user_avatar_width_for_size(size)
      self.letter_avatar_url(width * 2)
    end
  end

  def admin?
    email == Settings.site.owner_email
  end

  def letter_avatar_url(size)
    path = LetterAvatar.generate(self.name, size).sub('public/', '/')
    "//#{Settings.site.domain}:#{Settings.site.port}#{path}"
  end

  def user_avatar_width_for_size(size)
    case size
      when :normal then 48
      when :small then 16
      when :large then 96
      when :big then 120
      else size
    end
  end

  def email_md5
    Digest::MD5.hexdigest(self.email.downcase)
  end

  def gravatar_url #blocked in china
    "http://www.gravatar.com/avatar/#{self.email_md5}"
  end

  def calendar_data
    user = self
    Rails.cache.fetch(["user", self.id, 'calendar_data', Date.today, 'by-months']) do
      date_from = 12.months.ago.beginning_of_month.to_date
      dates = (date_from..Date.today).to_a
      replies = user.replies.reorder('date(created_at)').where('created_at > ?', date_from)
                    .group('date(created_at)')
                    .select('date(created_at) as date, count(id) as total_amount').all
      timestamps = {}
      replies.map do |reply|
        timestamps[reply['date'].to_time.to_i.to_s] = reply['total_amount']
      end
      timestamps
    end
  end

  private

  def update_ranking
    current_ranking = User.maximum(:ranking).to_i
    self.ranking = current_ranking + 1
  end

  def init_name
    self.name = self.uid
  end

  def init_avatar
    QiniuWorker.perform_async('init_user_avatar', user: self)
  end

  def send_welcome_mail
    SystemMailWorker.perform_async('welcome_mail', send_to: self.email)
  end

  def create_default_category
    category = self.categories.build(name: '我的文章', description: '默认文章分类')
    category.save
  end
end
