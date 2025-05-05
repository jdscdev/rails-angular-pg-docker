# frozen_string_literal: true

# It is part of the API namespace, which is used for building a RESTful API.
module Api
  # This controller manages the products in the system.
  class ProductsController < ApplicationController
    before_action :set_product, only: %i[show update destroy]
    before_action :validate_product_params, only: %i[create update]

    def index
      @products = Product.all
      render(json: @products)
    rescue StandardError => e
      render(json: { error: e.message }, status: :internal_server_error)
    end

    def show
      render(json: @product)
    rescue StandardError => e
      render(json: { error: e.message }, status: :internal_server_error)
    end

    def create
      @product = Product.new(product_params)
      return render(json: @product.errors, status: :unprocessable_entity) unless @product.save

      render(json: @product, status: :created)
    rescue StandardError => e
      render(json: { error: e.message }, status: :internal_server_error)
    end

    def update
      return render(json: @product.errors, status: :unprocessable_entity) unless @product.update(product_params)

      render(json: @product)
    rescue StandardError => e
      render(json: { error: e.message }, status: :internal_server_error)
    end

    def destroy
      @product.destroy
      head(:no_content)
    rescue StandardError => e
      render(json: { error: e.message }, status: :internal_server_error)
    end

    private

    def set_product
      params.permit(:id)
      product_id = params[:id].to_i
      return render(json: { error: 'Invalid Product ID' }, status: :bad_request) if product_id.zero?

      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render(json: { error: 'Product not found' }, status: :not_found)
    end

    def validate_product_params
      product_params = params[:product]
      return render(json: { error: 'Invalid Product Name' }, status: :bad_request) if product_params[:name].blank?

      render(json: { error: 'Invalid Product Price' }, status: :bad_request) if product_params[:price].to_f <= 0 ||
                                                                                product_params[:price].to_f > 1_000_000
    end

    def product_params
      params.require(:product).permit(:name, :price)
    end
  end
end
