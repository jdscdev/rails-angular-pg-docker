# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Products', type: :request do
  describe 'GET /api/products' do
    it 'returns a successful response' do
      get '/api/products'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of products' do
      create(:product, name: 'Product 1', price: 10.0)
      create(:product, name: 'Product 2', price: 20.0)

      get '/api/products'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns the correct product attributes' do
      create(:product, name: 'Product 1', price: 12.34)

      get '/api/products'
      expect(response).to have_http_status(:ok)
      products = JSON.parse(response.body)
      expect(products.first['name']).to eq('Product 1')
      expect(products.first['price']).to eq('12.34')
    end
  end
end
