class Message < ActiveRecord::Base

  #Association
  belongs_to :user
  belongs_to :sender, class: User, foreign_key: :from_user_id
  belongs_to :target, polymorphic: true

  #Validate
  validates :user_id, presence: true
  validates :from_user_id, presence: true
  # validates :target, presence: true

  #scope
  default_scope -> { order('created_at desc') }
  scope :unreads, -> { where(is_read: false) }

  def created_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end
end
