# frozen_string_literal: true

class Task::TaskUpdator
  def initialize(task)
    @task = task
    @old_url = task.url
    super()
  end

  def update!(attributes)
    after_update if @task.update attributes

    @task
  end

  private

  def after_update
    return unless @task.web_scraping? && url_changed?

    mark_as_pending
    scrape
  end

  def url_changed?
    @old_url != @task.url
  end

  def mark_as_pending
    @task.update status: :pending
  end

  def scrape
    ScraperJob.perform_later @task
  end
end
