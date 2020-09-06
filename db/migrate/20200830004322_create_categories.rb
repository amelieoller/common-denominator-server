class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :slug
      t.references :user, foreign_key: true
      t.string :custom_friendship_id, foreign_key: true

      t.timestamps
    end
  end
end
