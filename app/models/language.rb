class Language < ActiveRecord::Base

  #Association
  has_many :user_codes, dependent: :destroy, class: Code

  #Validate
  validates :name, presence: true, allow_blank: false
  validates :code, presence: true, allow_blank: false, uniqueness: {case_sensitive: false}

end
