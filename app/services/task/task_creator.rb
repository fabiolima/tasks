# frozen_string_literal: true

class Task::TaskCreator
  def initialize()
    super()
  end

  def create! task_params
    begin
      @task = Task.new task_params
      @task.save!
      after_create
      @task
    rescue 
      @task
    end
  end

  private

  def after_create
    scrape if @task.web_scraping? 
  end

  def scrape
    ScraperJob.perform_later @task
  end
end
