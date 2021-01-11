require 'rails_helper'

RSpec.describe "Api::Tags", type: :request do
  let!(:tags) { create_list(:tag, 10) }
  describe 'GET /api/tags' do
    it 'タグの一覧が取得できること' do
      get api_tags_path
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['tags']).to match_array(tags.map { |tag|
        include(
            'id' => tag.id,
            'name' => tag.name,
            )
      })
    end
  end
end