class OffersController < ApplicationController
  before_filter :load_task
  before_filter :authenticate_user!, except: [:create]

  def create
    @offer = Offer.new
    @offer.user = User.find_by_id(params[:user_id])
    @task.offers << @offer
    if @offer.save && @task.save
      render json: {offer: @offer, success: true }
    else
      render json: { success: false }
    end
  end

  def accept
    @task = Task.find_by_id(params[:task_id])
    redirect_to task_path(@task) and return unless current_user.id == @task.user.id
    @offer = Offer.find_by_id(params[:offer_id])
    assigned_to = Assignee.new
    assigned_to.user = @offer.user
    @task.assignee = assigned_to
    if assigned_to.save && @task.save
      flash[:notice] = {type: 'success', message: "Task assigned!"}
    else
      flash[:notice] = {type: 'failure', message: "Task not assigned!"}
    end
    redirect_to task_path(@task) and return
  end

  def index
    render 'offers/index' and return
  end

end
