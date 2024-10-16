class TasksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tasks"
  end

  def unsubscribed
  end

  # def receive(data)
  #   puts "###################"
  #   puts data
  #   ActionCable.server.broadcast("tasks", data)
  # end
end
