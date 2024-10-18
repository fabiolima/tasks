class AddResultToTasks < ActiveRecord::Migration[7.2]
  def change
    add_column :tasks, :result, :json
    add_column :tasks, :error_message, :string
  end
end
