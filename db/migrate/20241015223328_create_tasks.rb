class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.string :title
      t.integer :status, default: 0
      t.integer :task_type, default: 0
      t.string :url

      t.timestamps
    end
  end
end
