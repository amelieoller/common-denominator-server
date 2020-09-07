class AddHarmonyAndRandomnessToFriendship < ActiveRecord::Migration[6.0]
  def change
    add_column :friendships, :harmony, :decimal, default: 0.75
    add_column :friendships, :randomness, :decimal, default: 5
  end
end
