class RenameColumnFollowingUserIdInFollowings < ActiveRecord::Migration[5.1]
  def change
    rename_column :followings, :followee_id, :following_user_id
  end
end
