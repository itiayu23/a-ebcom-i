class CreateReadCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :read_counts do |t|
      t.integer :user_id
      t.integer :novel_id
      t.integer :pict_id

      t.timestamps
    end
  end
end
