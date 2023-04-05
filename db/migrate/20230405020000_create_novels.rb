class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :title, null: false
      t.text :text_body, null: false
      t.text :caption

      t.timestamps
    end
  end
end
