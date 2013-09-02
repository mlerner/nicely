module ApplicationHelper
  def devise_view?
    devise_controller?
  end
end
