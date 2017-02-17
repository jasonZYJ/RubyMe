class Category < ActiveRecord::Base

  #Association
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :codes, dependent: :destroy
  has_many :blogs, dependent: :destroy

  #Validate
  validates :user_id, presence: true
  validates :name, presence: true, allow_blank: false
  validates_uniqueness_of :name, scope: :user_id, case_sensitive: false

  before_destroy :validate_destroyable?

  def created_time
    self.created_at.strftime('%Y-%m-%d %H:%M')
  end

  private

  def validate_destroyable?
    if self.posts.size > 0
      errors.add(:base, "分类 #{self.name} 下还有文章，请先转移到其它分类！")
      false
    end
  end
end
