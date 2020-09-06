# class CreateUserFriends < ActiveRecord::Migration[6.0]
#   def change
#     create_table :user_friends do |t|
#       t.integer :user_id, null: false, foreign_key: true
#       t.integer :friend_id, null: false, foreign_key: true
#       t.boolean :accepted

#       t.timestamps
#     end
#   end
# end

class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :user, index: true, foreign_key: true
      t.references :friend, index: true
      t.boolean :accepted, default: true
      t.string :custom_friendship_id

      t.timestamps null: false
    end

    add_foreign_key :friendships, :users, column: :friend_id
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
