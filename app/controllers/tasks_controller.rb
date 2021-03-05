class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    if params[:order]
      case params[:order]
      when "endtime_asc"
        @tasks = Task.endtime_asc
      when "endtime_desc"
        @tasks = Task.endtime_desc
      end
    elsif params[:search]
      case params[:search]
      when "pending"
        @tasks = Task.find_pending
      when "progress"
        @tasks = Task.find_progress
      when "complete"
        @tasks = Task.find_complete
      end
    else
      @tasks = Task.all
    end
  end
  

  def new
    @task = Task.new
  end

  def create
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

  def state_update
    @task = Task.find(params[:id])
    if @task.pending?
      @task.progress!
      redirect_to root_path, notice:'狀態更新成功'
    elsif @task.progress?
      @task.complete!
      redirect_to root_path, notice:'狀態更新成功'
    else
      redirect_to root_path, notice:'狀態已經是完成'
    end
    # @task.progress! if @task.pending?
    # redirect_to root_path, notice:'狀態更新成功'
    # @task.complete! if @task.progress?
  end

  def search
    
  end

  private
  def params_task
    # {task: {name, content}}
    params.require(:task).permit(:name, :content, :endtime, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end