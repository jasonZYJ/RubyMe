module Frontend::UsersHelper
  def user_avatar_width_for_size(size)
    case size
      when :normal then 48
      when :small then 16
      when :large then 96
      when :big then 120
      else size
    end
  end
end
