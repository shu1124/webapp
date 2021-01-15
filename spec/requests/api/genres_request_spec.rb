require 'rails_helper'

RSpec.describe 'Api::Genres', type: :request do
  let!(:genres) { create_list(:genre, 10) }
  describe 'GET /api/genres' do
    it 'ジャンルの一覧が取得できること' do
      get api_genres_path
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['genres']).to match_array(genres.map do |genre|
        include(
          'id' => genre.id,
          'name' => genre.name
        )
      end)
    end
  end
end
