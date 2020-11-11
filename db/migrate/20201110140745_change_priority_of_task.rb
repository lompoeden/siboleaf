class ChangePriorityOfTask < ActiveRecord::Migration[6.0]
  def change
     change_column :tasks, :priority, :integer, default: '0'
  end
end
