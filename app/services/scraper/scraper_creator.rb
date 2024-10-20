# frozen_string_literal: true

require "net/http"

class Scraper::ScraperCreator
  def initialize(scrap_params)
    @webhook = Rails.application.credentials.endpoints.webhook
    @endpoint = Rails.application.credentials.endpoints.scraper
    @headers = { "Content-Type": "application/json" }
    @body = scrap_params.merge(webhook: @webhook)

    super()
  end

  def scrape
    uri = URI(@endpoint)

    Net::HTTP.post(uri, @body.to_json, @headers)
  end
end
