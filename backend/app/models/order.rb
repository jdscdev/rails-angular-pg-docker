class Order < ApplicationRecord
  enum status: { pending: 0, completed: 1, cancelled: 2 }

  belongs_to :user

  has_many :order_items
  has_many :products, through: :order_items

  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
