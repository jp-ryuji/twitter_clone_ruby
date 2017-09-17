class AddTimestampsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :created_at, :datetime, null: false
    add_column :posts, :updated_at, :datetime, null: false
  end
end
