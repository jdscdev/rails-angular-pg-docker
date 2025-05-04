# frozen_string_literal: true

# This controller manages the products in the system.
class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render(json: @products)
  end

  def show
    render(json: @product)
  end

  def create
    @product = Product.new(product_params)
    @product.save ? render(json: @product, status: :created) : render(json: @product.errors, status: :unprocessable_entity)
  end

  def update
    @product.update(product_params) ? render(json: @product) : render(json: @product.errors, status: :unprocessable_entity)
  end

  def destroy
    @product.destroy
    head(:no_content)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render(json: { error: 'Product not found' }, status: :not_found)
  end

  def product_params
    params.require(:product).permit(:name, :price)
  end
end
