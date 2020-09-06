class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :slug
      t.decimal :privilege, default: 1

      t.timestamps
    end
  end
end
