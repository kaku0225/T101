class TasksController < ApplicationController
  before_action :set_task, only:[:show, :edit, :update, :destroy]

  def index
    # @tasks = Task.order(created_at: :desc)
    @q = Task.ransack(params[:q])
    @tasks = @q.result(distinct: true)
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

  def priority_important
    if @tasks = Task.important
      @tasks = Task.not_important
    else
      @tasks = Task.important
    end
    render :index
  end

  def task_time
    if @tasks = Task.endtime
      @tasks = Task.starttime
    else
      @tasks = Task.endtime
    end
    render :index
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