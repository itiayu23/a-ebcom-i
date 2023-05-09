class AddColumnsToNovels < ActiveRecord::Migration[6.1]
  def change
    add_column :novels, :display, :string
  end
end
