require 'open-uri'
require 'resolv-replace'

class UserController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
  end

  def show
    render json: @user, status: 200
  end

  def create
    props = user_params.reverse_merge(count: 0, seed: 'giga')
    if props[:count].to_i < 0
      head 400
    else
      User.create fetch_users(*props.values_at(:count, :seed))
      head 201
    end
  end

  private

  def fetch_users(count, seed)
    seed = CGI.escape seed
    response = open "https://randomuser.me/api?seed=#{seed}&results=#{count}"
    json = JSON.parse response.read, symbolize_names: true
    json[:results].map do |user|
      avatar_url = user[:picture][:medium]
      avatar = open avatar_url
      ext = File.extname avatar_url || ".jpg"
      user.slice(:email, :phone, :cel).merge(
        title: user[:name][:title],
        name: "#{user[:name][:first]} #{user[:name][:last]}",
        avatar: App::StringIOFile.new(avatar, "avatar#{ext}")
      )
    end
  end

  def user_params
    params.permit :count, :seed
  end

  def set_user
    @user ||= User.find(params[:id])
  end
end
