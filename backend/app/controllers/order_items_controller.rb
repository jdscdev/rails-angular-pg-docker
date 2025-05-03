class OrderItemsController < ApplicationController
  before_action :set_order

  def index
    render json: @order.order_items
  end

  def create
    item = @order.order_items.new(order_item_params)
    if item.save
      render json: item, status: :created
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def update
    item = @order.order_items.find(params[:id])
    if item.update(order_item_params)
      render json: item
    else
      render json: item.errors, status: :unprocessable_entity
    end
  end

  def destroy
    item = @order.order_items.find(params[:id])
    item.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_item_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end
