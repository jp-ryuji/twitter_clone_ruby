class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.integer :followee_id, null: false
      t.integer :follower_id, null: false
    end
    add_index :followings, :followee_id
    add_index :followings, [:follower_id, :followee_id], unique: true
  end
end
