class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_task
    @task = Task.find_by_id(params[:task_id])
  end

  def after_sign_in_path_for(resource)
    redirect_to ((current_user.sign_in_count == 0) ? user_path(current_user) : root_path )
  end
end
