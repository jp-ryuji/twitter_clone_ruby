class AddIdTokenToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :id_token, :string, null: false, after: :id # NOTE: Use after when needed. Otherwise, a new column comes last.
    add_index :posts, :id_token, unique: true
  end
end
