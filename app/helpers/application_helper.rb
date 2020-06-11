module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def sklonyator (quantity, form1, form2, form3)
    if (11..14).include?(quantity % 100)
      form3
    elsif quantity % 10 == 1
      form1
    elsif (2..4).include?(quantity % 10)
      form2
    else
      form3
    end
  end
end
