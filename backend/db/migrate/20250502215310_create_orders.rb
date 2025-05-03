class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price
      t.integer :status, default: 0

      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
