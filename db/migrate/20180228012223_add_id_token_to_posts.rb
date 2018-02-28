class AddIdTokenToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :id_token, :string, null: false, after: :id
    add_index :posts, :id_token, unique: true
  end
end
