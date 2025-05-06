# frozen_string_literal: true

class Api::UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  before_action :validate_user_params, only: %i[create update]

  def index
    @users = User.all
    render(json: @users)
  rescue StandardError => e
    render(json: { error: e.message }, status: :internal_server_error)
  end

  def show
    render(json: @user)
  rescue StandardError => e
    render(json: { error: e.message }, status: :internal_server_error)
  end

  def create
    @user = User.new(user_params)
    return render(json: @user.errors, status: :unprocessable_entity) unless @user.save

    render(json: @user, status: :created)
  rescue StandardError => e
    render(json: { error: e.message }, status: :internal_server_error)
  end

  def update
    update_params = user_params.except(:email)
    return render(json: @user.errors, status: :unprocessable_entity) unless @user.update(update_params)

    render(json: @user)
  rescue StandardError => e
    render(json: { error: e.message }, status: :internal_server_error)
  end

  def destroy
    @user.destroy
    head(:no_content)
  rescue StandardError => e
    render(json: { error: e.message }, status: :internal_server_error)
  end

  private

  def set_user
    params.permit(:id)
    user_id = params[:id].to_i
    return render(json: { error: 'Invalid User ID' }, status: :bad_request) if user_id.zero?

    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render(json: { error: 'User not found' }, status: :not_found)
  end

  def validate_user_params
    render(json: { error: 'Invalid User Params' }, status: :bad_request) if params[:user][:name].blank? ||
                                                                            params[:user][:email].blank? ||
                                                                            params[:user][:password].blank?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
