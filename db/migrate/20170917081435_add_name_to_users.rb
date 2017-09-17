class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string, limit: 20
    add_column :users, :screen_name, :string, limit: 15, null: false
    add_index :users, :name
    add_index :users, :screen_name, unique: true
  end
end
