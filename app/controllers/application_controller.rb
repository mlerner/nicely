class ApplicationController < ActionController::Base
  protect_from_forgery

  def load_task
    @task = Task.find_by_id(params[:task_id])
  end

end
