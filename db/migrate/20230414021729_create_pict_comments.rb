class CreatePictComments < ActiveRecord::Migration[6.1]
  def change
    create_table :pict_comments do |t|
      t.integer :user_id
      t.integer :pict_id
      t.string :comment

      t.timestamps
    end
  end
end
