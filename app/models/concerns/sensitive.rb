module Sensitive
  extend ActiveSupport::Concern

  included do
    before_save :validate_sensitive
  end

  module ClassMethods
  end

  def validate_sensitive
    word = WordCheck::Worker.first_sensitive(self.inspect)
    if word.present?
      errors.add(:base, "当前内容包含敏感词汇: #{word}")
      false
    end
  end
end
