class ChangeColumnNullTasks < ActiveRecord::Migration[5.2]
  def change
    hange_column :tasks, :start_date, :datetime, null: false
        change_column :tasks, :end_date, :datetime, null: false
        change_column :tasks, :status, :string, null: false
      end
    end
