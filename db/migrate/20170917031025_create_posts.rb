class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.text :content, null: false
    end
  end
end
