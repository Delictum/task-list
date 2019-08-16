class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment_text
      t.datetime :created_by
      t.references :reply
      t.references :author, polymorphic: true

      t.timestamps
    end

    create_table :tasks_comments, id: false do |t|
      t.belongs_to :comment
      t.belongs_to :task
    end
  end
end
