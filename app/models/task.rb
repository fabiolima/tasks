class Task < ApplicationRecord
  enum task_type: %i[basic web_scraping]
  enum status: %i[pending in_progress completed error]
end
