class CreatePicts < ActiveRecord::Migration[6.1]
  def change
    create_table :picts do |t|

      t.timestamps
    end
  end
end
