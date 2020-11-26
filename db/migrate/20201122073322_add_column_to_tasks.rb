class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :enddate, :datetime
  end
end
