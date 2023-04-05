class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :novel_id
      t.integer :pict_id
      t.string :comment

      t.timestamps
    end
  end
end
