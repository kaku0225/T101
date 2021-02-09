class TasksController < ApplicationController
  def index
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new
    if @task.save
      redirect_to root_path, notice:'新增成功'
    else
      render :new
    end
  end

  private
  def params_task
    params.require(:task).permit(:name, :content)
  end
end