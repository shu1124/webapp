require 'rails_helper'

RSpec.describe Tag, type: :model do
  before do
    @tag = FactoryBot.build(:tag)
  end
  describe 'tagのモデルテスト' do
    it 'すべて適切に入力した場合は投稿できる' do
      expect(@tag).to be_valid
    end
    it 'nameが空の場合はエラー' do
      @tag.name = ''
      @tag.valid?
      expect(@tag.errors.full_messages).to include("Name can't be blank")
    end
    it 'メールアドレスが他の人と被っていた場合はエラー' do
      @tag.save
      other_tag = FactoryBot.build(:tag)
      other_tag.name = @tag.name
      other_tag.valid?
      expect(other_tag.errors.full_messages).to include('Name has already been taken')
    end
  end
end
