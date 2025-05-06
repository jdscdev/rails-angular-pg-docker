# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :registerable, :recoverable, :rememberable, :validatable and :omniauthable
  devise :database_authenticatable, :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null
  # has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_insensitive: true }, format: { with: Devise::email_regexp }
  validates :password, length: { minimum: 8 }, if: -> { new_record? || !password.nil? }

  has_many :orders, dependent: :destroy
end
