require 'rails_helper'

RSpec.describe 'Api::Comments', type: :request do
  describe 'GET /api/microposts/:micropost_id/comments' do
    context 'ページングなし' do
      let(:comment) { create(:comment) }
      it 'コメントの一覧が取得できること' do
        get api_micropost_comments_path(:micropost)
        expect(response).to have_http_status(200)
      end
    end
  end
end
