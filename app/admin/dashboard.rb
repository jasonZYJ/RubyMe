ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "最近的用户" do
          ul do
            User.order("created_at desc").limit(15).map do |user|
              li link_to(user.email, system_user_path(user))
            end
          end
        end
      end

      {Post: "最近的文章", Code: "最近的代码"}.each_pair do |key, value|
        column do
          panel value do
            ul do
              key.safe_constantize.limit(15).map do |record|
                omited_title = record.title.truncate(99, separator: ' ', omission: '...')
                li link_to(omited_title, send("system_#{record}_path", record))
              end
            end
          end
        end
      end
    end
  end
end
