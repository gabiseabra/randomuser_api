require 'open-uri'
require 'resolv-replace'

class UserController < ApplicationController
  include App::Response
  MAX_COUNT = 30

  before_action :set_user, only: %i[show]
  before_action :set_users, only: %i[index]

  def index
    render json: @users, only: User::JSON, status: 200
    headers['X-Pagination'] = json_pagination @users
  end

  def show
    render json: @user, only: User::JSON, status: 200
  end

  def create
    count = user_params[:count].to_i
    seed = user_params[:seed].to_s || 'giga'
    if count < 0 || count > MAX_COUNT
      render plain: '"count" must be between 1 and #{MAX_COUNT} ', status: 422
    else
      User.create fetch_users(count, seed)
      head 201
    end
  end

  private

  def fetch_users(count, seed)
    seed = CGI.escape seed
    response = open "https://randomuser.me/api?seed=#{seed}&results=#{count}"
    json = JSON.parse response.read, symbolize_names: true
    json[:results].map do |user|
      user.slice(:email, :phone, :cel).merge(
        title: user[:name][:title],
        name: "#{user[:name][:first]} #{user[:name][:last]}",
        avatar: fetch_avatar(user)
      )
    end
  end

  def fetch_avatar(user)
    avatar_url = user[:picture][:medium]
    avatar = open avatar_url
    ext = File.extname avatar_url || '.jpg'
    if avatar.is_a?(Tempfile)
      avatar
    else
      App::StringIOFile.new(avatar, "avatar#{ext}")
    end
  end

  def user_params
    params.permit :count, :seed, :q, :page
  end

  def set_user
    @user ||= User.find(params[:id])
  end

  def set_users
    page = user_params.fetch(:page, 1)
    begin
      @users = User.search(user_params[:q]).paginate(page: page.to_i)
    rescue RangeError
      render plain: "Invalid page range \"#{page}\"", status: 422
    end
  end
end
