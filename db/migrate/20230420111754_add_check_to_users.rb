class AddCheckToUsers < ActiveRecord::Migration[6.1]
  def change
    
     add_column :users, :check, :integer, default: 0
    
  end
end
