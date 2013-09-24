

class TasksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

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
    @user = Task.find(params[:id])
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
    if @task.assignee || @task.user.id != params[:user_id]
      @task.assignee = nil
      if @task.save
        render json: { success: true } and return
      end
    end
    render json: { success: false } and return
  end

  def complete
    redirect_to root_path
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
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
    @task.destroy

    respond_to do |format|
      format.html { redirect_to task_url }
      format.json { head :no_content }
    end
  end
end
