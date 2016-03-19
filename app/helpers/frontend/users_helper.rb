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

  def user_avatar_tag user, size = :normal
    width = user_avatar_width_for_size(size)
    img_class = "media-object avatar-#{width}"

    return image_tag("avatar/#{size}.png", class: img_class) if user.blank?

    if user.avatar?
      img = image_tag(user.avatar.url(user_avatar_size_name_for_2x(size)), class: img_class)
    else
      img = image_tag(user.letter_avatar_url(width * 2), class: img_class)
    end
    link_to(raw(img), user_path(user))
    # image_tag(current_user.avatar_url(:normal, :thumb)
  end

  def user_avatar_tag1(user, size = :normal, opts = {})
    # link = opts[:link].nil? ? true : opts[:link]

    # width = user_avatar_width_for_size(size)
    # img_class = "media-object avatar-#{width}"

    # if user.blank?
    #   # hash = Digest::MD5.hexdigest("") => d41d8cd98f00b204e9800998ecf8427e
    #   return image_tag("avatar/#{size}.png", class: img_class)
    # end
    #
    # if user.avatar?
    #   img = image_tag(user.avatar.url(user_avatar_size_name_for_2x(size)), class: img_class)
    # else
    #   img = image_tag(user.letter_avatar_url(width * 2), class: img_class)
    # end
    #
    # if link
    #   link_to(raw(img), user_path(user))
    # else
    #   raw img
    # end
  end
end
