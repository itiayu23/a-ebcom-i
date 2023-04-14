class CreatePictBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :pict_bookmarks do |t|
      t.integer :user_id
      t.integer :pict_id

      t.timestamps
    end
  end
end
