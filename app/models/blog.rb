class Blog < ApplicationRecord

  #Scope
  default_scope { order('created_at desc') }
  scope :visible, -> { where(status: 1) }

  #Validate
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :category
  belongs_to :user
  has_one :postgresql_search, as: :searchable

  #Constants
  STATUSES = %W(隐藏 显示)
  CATEGORIES = %W(通知 功能)

  after_save do
    if self.content_changed? || self.title_changed?
      SearchIndexerWorker.perform_async('blog', self.id)
    end
  end

  def published_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def to_search_data
    %Q(#{self.title} #{PostgresqlSearch.scrub_html_for_search self.content})
  end

  def type
    CATEGORIES[self.category]
  end
end
