class AdminController < ApplicationController
  include AdminHelper

  layout 'admin/home'

  before_filter :authenticate_user!
end
