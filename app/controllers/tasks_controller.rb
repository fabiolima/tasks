class TasksController < ApplicationController
  before_action :authenticate_user!
  def index
    @tasks = Task.where(user_id: current_user.id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params

    if @task.save!
      ActionCable.server.broadcast("tasks", {
        name: "teste",
        message: "teste"
      })

      redirect_to tasks_path
    else
      render :create
    end
  end

  private

  def task_params
    params.require(:task).permit(:user_id, :title, :task_type, :url, :status)
  end
end
