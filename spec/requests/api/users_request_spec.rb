require 'rails_helper'

RSpec.describe "Api::Users", type: :request do

  describe 'GET /api/users' do
    context 'ページングなし' do
      let!(:users) { create_list(:user, 5) }
      it 'ユーザーの一覧が取得できること' do
        get api_users_path
        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['users']).to match_array(users.map { |user|
          include(
              'id' => user.id,
              'name' => user.name,
              'tags' => be_a(Array)
          )
        })
      end
    end

    context 'ページングあり' do
      let!(:users) { create_list(:user, 25) }
      it 'ユーザーの一覧が取得できること' do
        get api_users_path
        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['meta']).to include(
                                    'total_pages' => 3,
                                    'total_count' => 25,
                                    'current_page' => 1
                                )
      end
    end
  end

  describe 'POST /api/users' do
    let(:user_params) { { user: { name: 'dyson', email: 'dyson@example.com', password: '12345678', password_confirmation: '12345678' } } }
    it 'ユーザーが作成できること' do
      post api_users_path, params: user_params
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['user']).to include({
                                          'id' => be_present,
                                          'name' => 'dyson',
                                          'email' => 'dyson@example.com',
                                      })
    end

    let(:invalid_user_params) { { user: { name: 'dyson', email: 'dyson@example.com', password: '12345678', password_confirmation: '1234' } } }
    it 'ユーザーの作成に失敗すること' do
      post api_users_path, params: invalid_user_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['error']).to be_present
    end
  end

  describe 'GET /api/users/:id' do
    let(:user) { create(:user) }
    it 'ユーザーの詳細が取得できること' do
      get api_user_path(user)
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['user']).to include({
                                          'id' => user.id,
                                          'name' => user.name,
                                          'email' => user.email,
                                          'introduction' => user.introduction,
                                      })
    end
  end
end