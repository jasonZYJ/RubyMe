# Sends admin mail for system events
class SystemMailer < ActionMailer::Base
  default from: Settings.site_mailer.from, return_path: Settings.site_mailer.return_path

  def welcome_mail(params)
    @send_to = params["send_to"]

    send_mail("#{Settings.site.name} 欢迎你", "mailers/system_mailer/welcome_register")
  end

  def sensitive_mail(params)
    @send_to = params["send_to"]
    @content = params["content"]

    send_mail("#{Settings.site.name}敏感词检测结果", "mailers/system_mailer/page_sensitive")
  end

  def send_mail(subject, render_path)
    mail(to: @send_to, subject: subject) do |format|
      format.html { render render_path, layout: false }
    end
  end
end

