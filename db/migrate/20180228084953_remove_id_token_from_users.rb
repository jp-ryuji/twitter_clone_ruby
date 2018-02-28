class RemoveIdTokenFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :id_token
  end
end
