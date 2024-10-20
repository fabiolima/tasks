class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  before_action :set_event

  def create
    case @event[:type]
    when "task.status.completed" then handle_status_completed @event
    when "task.status.error" then handle_status_error @event
    end

    head :ok
  end

  private

  def set_event
    json_body = JSON.parse(request.body.read, symbolize_names: true)
    @event = json_body[:event]
  end

  def handle_status_completed(event)
    task = Task.find(event[:resource][:id])
    task.update(result: event[:result], status: Task.statuses[:completed])
    broadcast_task task
  end

  def handle_status_error(event)
    task = Task.find(event[:resource][:id])
    task.update(status: Task.statuses[:error], error_message: event[:error_message])
    broadcast_task task
  end

  def broadcast_task(task)
    rendered_task_detail = ApplicationController.renderer.render(
      partial: "tasks/task_details",
      locals: { task: task }
    )

    ActionCable.server.broadcast("tasks", { task: task, html: rendered_task_detail })
  end
end
