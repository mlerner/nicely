module PagesHelper
  DEFAULT_TABS = ['new', 'submitted-tasks']
  def current_tab
    params[:tab] ||= 'default'
  end

  def current_sort_order
    params[:sort] ||= 'top'
  end

  def current_time_order
    params[:time] ||= 'today'
  end

  def generate_class(tab, other_styles = nil)
    tab << ' selected' if tab_selected?(tab)
    tab
  end

  def liked(task)

    if user_signed_in? && current_user.likes?(task)
      'red-full-heart'
    else
      'red-empty-heart'
    end
  end

  def task_distance(task)
    if request.location.coordinates[0] > 0.0
      geocoded_location = [request.location.coordinates[0], request.location.coordinates[1]]
    else
      geocoded_location = [42.4439614, -76.5018807]
    end
    haversine_distance(geocoded_location[0], geocoded_location[1], task.start_xy.lat, task.start_xy.lon).round(2)
  end

  def tab_selected?(tab)
    (current_tab == 'default' && DEFAULT_TABS.include?(tab)) ||
    tab == current_tab ||
    tab == current_sort_order ||
    tab == current_time_order
  end
end
