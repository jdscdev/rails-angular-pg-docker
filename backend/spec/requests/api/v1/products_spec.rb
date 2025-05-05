# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Products', type: :request do
  describe 'GET /api/products' do
    it 'returns a successful response' do
      get('/api/products')
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of products' do
      create(:product, name: 'Product 1', price: 10.0)
      create(:product, name: 'Product 2', price: 20.0)

      get('/api/products')
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it 'returns the correct product attributes' do
      create(:product, name: 'Product 1', price: 12.34)

      get('/api/products')
      expect(response).to have_http_status(:ok)
      products = JSON.parse(response.body)
      expect(products.first['name']).to eq('Product 1')
      expect(products.first['price']).to eq('12.34')
    end

    it 'returns an empty array when no products exist' do
      get('/api/products')
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'handles errors gracefully' do
      allow(Product).to receive(:all).and_raise(StandardError.new('Database error'))
      get('/api/products')
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Database error' })
    end
  end

  describe 'GET /api/products/:id' do
    it 'returns a successful response' do
      product = create(:product)
      get("/api/products/#{product.id}")
      expect(response).to have_http_status(:ok)
    end

    it 'returns the correct product' do
      product = create(:product, name: 'Product 1', price: 12.34)
      get("/api/products/#{product.id}")
      expect(response).to have_http_status(:ok)
      product_response = JSON.parse(response.body)
      expect(product_response['name']).to eq('Product 1')
      expect(product_response['price']).to eq('12.34')
    end

    it 'returns a 404 error for non-existent products' do
      get('/api/products/999')
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Product not found' })
    end
  end

  describe 'POST /api/products' do
    it 'creates a new product' do
      post('/api/products', params: { product: { name: 'Product 1', price: 12.34 } })
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['name']).to eq('Product 1')
      expect(JSON.parse(response.body)['price']).to eq('12.34')
    end

    it 'returns a bad request for invalid product name' do
      post('/api/products', params: { product: { name: '', price: 123 } })
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'returns a bad request for negative product price' do
      post('/api/products', params: { product: { name: 'Product 1', price: -5 } })
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'returns a bad request for invalid product price' do
      post('/api/products', params: { product: { name: 'Product 1', price: 'asd' } })
      expect(response).to have_http_status(:bad_request)
      expect(JSON.parse(response.body)).not_to be_empty
    end

    it 'handles errors gracefully' do
      allow(Product).to receive(:new).and_raise(StandardError.new('Database error'))
      post('/api/products', params: { product: { name: 'Product 1', price: 12.34 } })
      expect(response).to have_http_status(:internal_server_error)
      expect(JSON.parse(response.body)).to eq({ 'error' => 'Database error' })
    end
  end
end
