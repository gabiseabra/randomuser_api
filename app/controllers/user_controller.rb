class UserController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
  end

  def show
    render json: @user, status: 200
  end

  def create
  end

  private

  def user_params
    params.permit(:id)
  end

  def set_user
    @user ||= User.find(user_params[:id])
  end
end
