require 'rails_helper'

RSpec.describe Genre, type: :model do
  before do
    @genre = FactoryBot.build(:genre)
  end
  describe 'genreのモデルテスト' do
    it 'すべて適切に入力した場合は投稿できる' do
      expect(@genre).to be_valid
    end
    it 'nameが空の場合はエラー' do
      @genre.name = ''
      @genre.valid?
      expect(@genre.errors.full_messages).to include("Name can't be blank")
    end
    it 'genreが被った場合はエラー' do
      @genre.save
      other_genre = FactoryBot.build(:genre)
      other_genre.name = @genre.name
      other_genre.valid?
      expect(other_genre.errors.full_messages).to include('Name has already been taken')
    end
  end
end
