class CreateDrawTags < ActiveRecord::Migration[6.1]
  def change
    create_table :draw_tags do |t|
       t.references :pict_tag, foreign_key: true
       t.references :pict, foreign_key: true

      t.timestamps
    end
    
  end
end
