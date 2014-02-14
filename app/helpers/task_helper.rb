module TaskHelper
  def has_user_offer?
    current_user && !@task.offers.where(user_id: current_user.id).empty?
  end

  def has_user_report?
    current_user && !@task.reports.where(user_id: current_user.id).empty?
  end
end
