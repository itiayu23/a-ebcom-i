class CreateNovels < ActiveRecord::Migration[6.1]
  def change
    create_table :novels do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :title
      t.text :text_body
      t.text :caption
      t.string :privacy

      t.timestamps
    end
  end
end
