module ApplicationHelper
  def devise_view?
    devise_controller?
  end

  def gravatar_url(email)
    hash = Digest::MD5.hexdigest(email)
    "http://www.gravatar.com/avatar/#{hash}?s=40&d=mm"
  end
end
