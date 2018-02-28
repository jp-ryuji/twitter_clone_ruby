class AddIdTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :id_token, :string, null: false, after: :id # NOTE: Use after when needed. Otherwise, a new column comes last.
    add_index :users, :id_token, unique: true
  end
end
