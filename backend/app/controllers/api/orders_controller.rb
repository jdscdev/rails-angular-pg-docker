# frozen_string_literal: true

# It is part of the API namespace, which is used for building a RESTful API.
module Api
  # This controller manages the orders in the system.
  class OrdersController < ApplicationController
    before_action :set_order, only: %i[show update destroy]

    def index
      @orders = Order.all
      render(json: @orders)
    end

    def show
      render(json: @order)
    end

    def create
      @order = Order.new(order_params)
      @order.save ? render(json: @order, status: :created) : render(json: @order.errors, status: :unprocessable_entity)
    end

    def update
      update_params = order_params.except(:user_id)
      @order.update(update_params) ? render(json: @order) : render(json: @order.errors, status: :unprocessable_entity)
    end

    def destroy
      @order.destroy
      head(:no_content)
    end

    private

    def set_order
      @order = Order.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render(json: { error: 'Order not found' }, status: :not_found)
    end

    def order_params
      params.require(:order).permit(:user_id, :status)
    end
  end
end
