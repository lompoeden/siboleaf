class AddTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :startdate, :datetime
    add_column :tasks, :priority, :integer
    add_column :tasks, :status, :string
  end
end
