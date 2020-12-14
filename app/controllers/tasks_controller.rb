class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :current_user
    before_action :authenticate_user
    before_action :logged_in?
    PER = 4

  def index
    Task.page(4)
    @search = Task.ransack(params[:q])
    if params[:q]
      @tasks = @search.result.page params[:page]
    elsif params[:search_label]
    @tasks = Task.joins(:labels)
        .where("labels.name ILIKE ?", "%#{params[:search_label]}%").page params[:page]
    elsif params[:sort_deadline]
      @tasks = Task.all.order('end_at DESC').page params[:page]
    elsif params[:sort_priority]
      @tasks = Task.all.order('priority DESC').page params[:page]
    else
      @tasks = Task.where(user_id: @current_user.id).order('created_at DESC ').page(params[:page])
    end
  end


  def new
    @task = Task.new
    current_user = @current_user
    @labels = Label.all
  end

  def show
    @labels = Label.all
  end

  def edit
    @labels = Label.all
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @task.save
        flash[:success] = 'Task created'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task cannot be created'
        render :new
      end
    end
  end

  def update
      if @task.update(task_params)
        flash[:success] = 'Task updated'
        redirect_to tasks_path
      else
        flash.now[:danger] = 'Task not updated'
        render :edit
      end
    end

  def destroy
    @task.destroy
    flash[:success] = 'Task created'
    redirect_to tasks_url, notice: "task destroyed"
  end

  private
  def check_if_logged_in
    if !logged_in?
      redirect_to new_session_path, notice: "you are not authorized to access this page"
    end
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :priority, :startdate, :enddate, :id, :user_id)
  end
end
