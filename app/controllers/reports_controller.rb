class ReportsController < ApplicationController
  before_filter :load_task

  def create
    @report = Report.new
    @report.user = User.find_by_id(params[:user_id])
    @task.reports << @report
    if @report.save && @task.save
      render json: {report: @report, success: true }
    else
      render json: { success: false }
    end
  end
end
