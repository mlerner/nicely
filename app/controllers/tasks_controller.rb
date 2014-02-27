

class TasksController < ApplicationController
  before_filter :authenticate_user!, only: [:like, :new, :edit, :update, :destroy, :complete, :chat]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html { render layout: 'application', template: 'tasks/new' }
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html {render layout: 'application', template: 'tasks/show' }  # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new
    @back_path = request.referer || root_path
    respond_to do |format|
      format.html {
        render layout: 'application', template: 'tasks/new'
      }
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    redirect_to task_path(@task) and return
  end

  def delete
    @task = Task.find_by_id(params[:id])
    @task.destroy
    if @task.destroyed?
      render json: { success: true } and return
    else
      render json: { success: false } and return
    end
  end

  def like
    @task = Task.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    @user.like(@task)
    if @user.likes?(@task)
      render json: { success: true } and return
    else
      render json: { success: false } and return
    end
  end

  def unlike
    @task = Task.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    @user.unlike(@task)
    if !@user.likes?(@task)
      render json: { success: true } and return
    else
      render json: { success: false } and return
    end
  end

  def revoke
    @task = Task.find_by_id(params[:id])
    if @task.assignee
      @task.assignee = nil
      if @task.save
        render json: { success: true } and return
      end
    end
    render json: { success: false } and return
  end

  def complete
    @task = Task.find(params[:id])
    task_completer = @task.assignee.user
    task_completer.points += @task.liked_by_count + @task.points
    @task.status = 1
    if @task.save && task_completer.save
      puts task_completer.points
      render 'tasks/complete' and return
    else
      flash[:notice] =  {type: "failure", message: "Task not completed"}
      redirect_to task_path(@task) unless @task.is_owner?(current_user)
    end
  end

  def chat
    @task = Task.find(params[:id])
    unless @task.user.id == current_user.id ||
        (@task.assignee && @task.assignee.user.id == current_user.id)
      redirect_to task_path(@task) and return
    end

    @message = Message.new
    render 'tasks/chat' and return
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = User.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:user])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    #@task.destroy

    respond_to do |format|
      format.html { redirect_to task_url }
      format.json { head :no_content }
    end
  end
end
