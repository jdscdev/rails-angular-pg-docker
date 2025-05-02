class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
