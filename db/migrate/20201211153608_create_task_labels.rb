class CreateTaskLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :task_labels do |t|
      t.bigint "task_id"
      t.bigint "label_id"

      t.timestamps
    end
  end
end
