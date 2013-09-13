module PagesHelper
  def current_tab
    params[:tab] ||= 'helpers'
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

  def tab_selected?(tab)
    tab == current_tab ||
    tab == current_sort_order ||
    tab == current_time_order
  end
end
