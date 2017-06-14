require 'word_check'
include WordCheck::Worker

class Post < ApplicationRecord
  include Reflections
  include Sensitive

  #Association
  belongs_to :user, counter_cache: true
  belongs_to :last_reply_user, class_name: User, foreign_key: :last_reply_user_id
  belongs_to :point
  belongs_to :category
  has_many :replies, dependent: :destroy, counter_cache: true
  has_one :postgresql_search, as: :searchable

  #Validate
  validates :user_id, presence: true
  validates :point_id, presence: true
  validates :category_id, presence: true
  validates :source, presence: true
  validates :title, presence: true, allow_blank: false
  validates :content, presence: true, allow_blank: false

  #Constants
  SOURCES = %W(原创 翻译 转载 其他) #FIXME if we need to save these source to db

  #Scope
  default_scope -> { order('created_at desc') }
  scope :no_reply, -> { where(replies_count: 0) }
  scope :popular, -> { where('likes_count > 5') }
  scope :excellent, -> { where('excellent >= 1') }

  #Callback
  before_save :validate_tags

  after_save do
    if self.content_changed? || self.title_changed?
      SearchIndexerWorker.perform_async('post', self.id)
    end
  end

  def to_search_data
    "#{self.title} #{PostgresqlSearch.scrub_html_for_search self.content}"
  end

  def published_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  private

  def validate_tags
    if self.tags.split(/,/).size > 5
      errors.add(:tags, '关键词超过5个了')
      false
    end
  end
end
