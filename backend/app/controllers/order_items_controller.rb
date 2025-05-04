# frozen_string_literal: true

# This file is part of the Order Management System.
class OrderItemsController < ApplicationController
  before_action :set_order

  def index
    render(json: @order.order_items)
  end

  def create
    item = @order.order_items.new(order_item_params)
    item.save ? render(json: item, status: :created) : render(json: item.errors, status: :unprocessable_entity)
  end

  def update
    item = @order.order_items.find(params[:id])
    update_params = order_item_params.except(:product_id)
    item.update(update_params) ? render(json: item) : render(json: item.errors, status: :unprocessable_entity)
  end

  def destroy
    item = @order.order_items.find(params[:id])
    item.destroy
    head(:no_content)
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  rescue ActiveRecord::RecordNotFound
    render(json: { error: 'Order not found' }, status: :not_found)
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
