class ApplicationController < ActionController::Base

  def load_task
    @task = Task.find_by_id(params[:task_id])
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
