class ScraperJob < ApplicationJob
  queue_as :default

  def perform(task)
    Scraper::ScraperCreator.new({ id: task.id, url: task.url }).scrape
  end
end
