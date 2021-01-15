require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @micropost = FactoryBot.build(:micropost)
  end
  describe 'micropostのモデルテスト' do
    it 'すべて適切に入力した場合は出品できる' do
      expect(@micropost).to be_valid
    end
    it 'contentが空の場合はエラー' do
      @micropost.content = ''
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include("Content can't be blank")
    end
    it 'titleがない場合はエラー' do
      @micropost.title = nil
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include("Title can't be blank")
    end
    it 'titleが30文字以上の場合はエラー' do
      @micropost.title = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include('Title is too long (maximum is 30 characters)')
    end
    it 'timeがない場合はエラー' do
      @micropost.time = ''
      @micropost.valid?
      expect(@micropost.errors.full_messages).to include("Time can't be blank")
    end
  end
end
