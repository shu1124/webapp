require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end
  describe 'commentモデルのテスト' do
    it 'すべて適切に入力した場合は出品できる' do
      expect(@comment).to be_valid
    end
    it 'commentが空の場合はエラー' do
      @comment.content = ''
      @comment.valid?
      expect(@comment.errors.full_messages).to include("Content can't be blank")
    end
  end
end
