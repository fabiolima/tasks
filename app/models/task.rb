class Task < ApplicationRecord
  enum :task_type, [:basic, :web_scraping]
  enum :status, [:pending, :in_progress, :completed, :error]

  validates :title, presence: true
  validates :url, presence: true, url: true
  validates :task_type, presence: true
end
