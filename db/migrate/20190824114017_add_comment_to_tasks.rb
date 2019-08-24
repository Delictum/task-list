class AddCommentToTasks < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :task, foreign_key: true

    drop_table :tasks_comments do |t|
      t.integer :comment_id
      t.integer :task_id
      t.timestamps null: false
    end
  end
end
