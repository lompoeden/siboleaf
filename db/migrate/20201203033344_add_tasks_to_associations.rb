class AddTasksToAssociations < ActiveRecord::Migration[5.2]
  def change
    add_reference :associations, :task, foreign_key: true
end
