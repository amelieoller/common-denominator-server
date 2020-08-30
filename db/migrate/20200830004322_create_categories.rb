class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.references :friendship, null: true, foreign_key: true

      t.timestamps
    end
  end
end
