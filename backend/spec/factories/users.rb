# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    name { 'John Doe' }
    email { 'test@example.com' }
    password { 'password1' }
    created_at { Time.current }
    updated_at { Time.current }
  end
end
