class CreateNotices < ActiveRecord::Migration[6.1]
  def change
    create_table :notices do |t|
      # 通知を送ったユーザー
      t.integer :visitor_id
      # 通知を送られたユーザー
      t.integer :visited_id
      t.integer :bookmark_id
      t.integer :comment_id
      t.string :action
      t.boolean :checked
      
      t.timestamps
    end
  end
end
