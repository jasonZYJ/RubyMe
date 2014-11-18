
class FrontendController < ApplicationController
  include ApplicationHelper
  include FrontendHelper

  layout 'frontend/home'

  before_action :load_messages, if: Proc.new { current_user.present? }

  def load_messages
    @messages = current_user.messages
  end

  def title
     "#{site_intro}首页"
  end

end
