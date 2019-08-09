class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings, id: :uuid do |t|
      t.uuid :followee_id, null: false
      t.uuid :follower_id, null: false
    end
    add_index :followings, :followee_id
    add_index :followings, [:follower_id, :followee_id], unique: true
  end
end
