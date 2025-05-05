# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    email { 'test@example.com' }
    password { 'password1' }
  end
end
