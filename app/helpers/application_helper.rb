module ApplicationHelper
  def devise_view?
    devise_controller?
  end

  def gravatar_url(email, size = '40')
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}&d=mm"
  end

  def distance_between_points(first_point, second_point)
  end

end
