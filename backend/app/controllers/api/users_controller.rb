# frozen_string_literal: true

# It is part of the API namespace, which is used for building a RESTful API.
module Api
  # It provides actions to create, read, update, and delete users.
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
      @users = User.all.map do |user|
        user.as_json(except: [:password_digest])
      end
      render(json: @users)
    end

    def show
      render(json: @user)
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render(json: @user.as_json(except: [:password_digest]), status: :created)
      else
        render(json: @user.errors, status: :unprocessable_entity)
      end
    end

    def update
      update_params = user_params.except(:email)
      if @user.update(update_params)
        render(json: @user.as_json(except: [:password_digest]))
      else
        render(json: @user.errors, status: :unprocessable_entity)
      end
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

    def set_user
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render(json: { error: 'User not found' }, status: :not_found)
    end

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
  end
end
