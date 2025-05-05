# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:id) { |n| n }
    name { 'Sample Product' }
    price { 19.99 }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
