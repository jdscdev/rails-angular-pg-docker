class Order < ApplicationRecord
  enum status: { pending: 0, completed: 1, cancelled: 2 }

  validates :status, presence: true
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
end
