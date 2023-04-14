class CreatePictTags < ActiveRecord::Migration[6.1]
  def change
    create_table :pict_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
