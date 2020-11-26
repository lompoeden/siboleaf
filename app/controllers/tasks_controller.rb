class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
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
      @tasks = Task.all.order('created_at DESC').page params[:page]
    end
  end

  def new
      @task = Task.new
  end

  def show
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
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
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :status, :priority, :startdate, :enddate)
  end
end
