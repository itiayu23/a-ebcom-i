class CreatePicts < ActiveRecord::Migration[6.1]
  def change
    create_table :picts do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :title, null: false
      t.text :caption

      t.timestamps
    end
  end
end
