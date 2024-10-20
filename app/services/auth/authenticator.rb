# frozen_string_literal: true

require "net/http"

class Auth::Authenticator
  def initialize(credentials)
    @credentials = credentials
    super()
  end

  def authenticate
    uri = URI(Rails.application.credentials.endpoints.authenticate)
    payload = { user: @credentials }.to_json
    headers = { "Content-Type": "application/json" }

    Net::HTTP.post(uri, payload, headers)
  end
end
