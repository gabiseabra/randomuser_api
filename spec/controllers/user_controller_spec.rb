require 'rails_helper'

RSpec.describe UserController, type: :controller do
  let!(:users) { create_list :user, 10 }
  let(:user) { User.last }
  let(:json) { JSON.parse response.body, symbolize_names: true }
  
  describe 'GET /' do
    let(:pagination) { JSON.parse response.headers['X-Pagination'], symbolize_names: true }

    before { get :index, params: { page: page } }

    context 'with valid page range' do
      let(:page) { 1 }

      it 'Returns a list of users' do
        json.length.should be_between(10, User.per_page)
      end

      it 'Responds with a X-Pagination header' do
        pagination.keys.should eq(%i[entries pages per_page])
      end

      it 'Responds with status 200' do
        response.status.should == 200
      end
    end

    context 'with invalid page range' do
      let(:page) { 0 }

      it 'Responds with status 422' do
        response.status.should == 422
      end
    end
  end

  describe 'GET /:id' do
    before { get :show, params: { id: user_id } }

    context 'with valid user id ' do
      let(:user_id) { user.id }

      it 'Returns requested user\'s data' do
        json[:id].should == user_id
      end

      it 'Filters allowed properties' do
        json.keys.should eq(User::JSON)
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
