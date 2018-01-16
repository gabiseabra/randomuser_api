require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let!(:users) { create_list :user, 10 }
  let(:user) { User.last }

  describe 'GET /' do
    before { get :index }

    it 'Returns a list of users'
  end

  describe 'GET /:id' do
    before { get :show, params: { id: user_id } }

    context 'with valid user id ' do
      let(:user_id) { user.id }

      it 'Returns an user\'s data' do
        json = JSON.parse response.body
        response.status.should == 200
        json['id'].should == user.id
      end
    end

    context 'with invalid user id' do
      let(:user_id) { 0 }

      it 'Returns 404' do
        response.status.should == 404
      end
    end
  end
end
