class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visiter_id
      t.integer :visited_id
      t.integer :pict_id
      t.integer :novel_id
      t.integer :comment_id
      t.integer :pict_comment_id
      t.string :action
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
