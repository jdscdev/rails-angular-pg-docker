class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
    add_index :users, :email, unique: true
  end
end
