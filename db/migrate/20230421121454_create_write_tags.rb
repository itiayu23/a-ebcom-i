class CreateWriteTags < ActiveRecord::Migration[6.1]
  def change
    create_table :write_tags do |t|
       t.references :tag, foreign_key: true
       t.references :novel, foreign_key: true

      t.timestamps
    end
  end
end
