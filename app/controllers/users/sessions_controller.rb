# encoding: utf-8
class Users::SessionsController < Devise::SessionsController

  def create
    if verify_rucaptcha?
      super
    else
      clean_up_passwords(resource)
      flash.delete :captcha_error
      redirect_to new_user_session_path , alert: "验证码不匹配，请重新输入"
    end
  end

end
