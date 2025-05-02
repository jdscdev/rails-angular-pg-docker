class OrderItem < ApplicationRecord
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # Associations
  belongs_to :order
  belongs_to :product
end
