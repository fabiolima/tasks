class WebhookController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]

  def create
    ActionCable.server.broadcast("tasks", {
      name: "teste",
      message: "teste"
    })

    head :ok
  end
end
