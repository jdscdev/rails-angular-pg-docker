# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'Sample Product' }
    price { 19.99 }
  end
end
