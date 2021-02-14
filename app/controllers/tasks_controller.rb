class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    # byebug
    @task = Task.new(params_task)
    if @task.save
      redirect_to root_path, notice:'新增成功'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(params_task)
      redirect_to root_path, notice:'編輯成功'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice:'刪除成功'
  end

  private
  def params_task
    # {task: {name, content}}
    params.require(:task).permit(:name, :content)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end