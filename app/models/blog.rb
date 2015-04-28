class Blog < ActiveRecord::Base

  #Scope
  default_scope { order('created_at desc') }
  scope :visible, -> { where(status: 1) }

  #Validate
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :category
  belongs_to :user

  #Constants
  STATUSES = %W(隐藏 显示)
  CATEGORIES = %W(通知 功能)

  def published_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  def type
    CATEGORIES[self.category]
  end
end
