class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [ :show, :edit, :update ]

  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task::TaskCreator.new.create! task_params

    respond_to do |format|
      if @task.persisted?
        format.html { redirect_to task_path(@task) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    @task = Task::TaskUpdator.new(@task).update! task_params

    respond_to do |format|
      if @task.valid?
        format.html { redirect_to task_path(@task) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:user_id, :title, :task_type, :url, :status)
  end
end
