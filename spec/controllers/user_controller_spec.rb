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

      it 'Returns requested user\'s data' do
        json = JSON.parse response.body
        json['id'].should == user_id
      end

      it 'Responds with status 200' do
        response.status.should == 200
      end
    end

    context 'with invalid user id' do
      let(:user_id) { 0 }

      it 'Responds with status 404' do
        response.status.should == 404
      end
    end
  end

  describe 'POST /' do
    before { post :create, params: { count: 10 } }

    it 'Responds with status 201' do
      response.status.should == 201
    end

    it 'Creates reqested number of entries' do
      User.count.should == 20
    end

    it 'Uploads user avatars' do
      User.last.avatar.file.should exist
    end
  end
end
