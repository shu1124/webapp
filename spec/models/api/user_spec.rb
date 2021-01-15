require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー管理機能テスト' do
    it 'すべての項目を適切に入力した場合はログイン可能' do
      expect(@user).to be_valid
    end
    it 'メールアドレスの入力がない場合はエラー' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'メールアドレスが他の人と被っていた場合はエラー' do
      @user.save
      other_user = FactoryBot.build(:user)
      other_user.email = @user.email
      other_user.valid?
      expect(other_user.errors.full_messages).to include('Email has already been taken')
    end
    it 'メールアドレスに@がない場合はエラー' do
      @user.email = 'aaaaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end
    # it 'パスワードがない場合はエラー' do
    #   @user.password = ''
    #   @user.valid?
    #   expect(@user.errors.full_messages).to include("Password can't be blank")
    # end
    # it 'パスワードが5文字以下の場合はエラー' do
    #   @user.password = 'aaaaa'
    #   @user.password_confirmation = 'aaaaa'
    #   @user.valid?
    #   expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    # end
    it '確認用パスワードがない場合はエラー' do
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '確認用パスワードがパスワードと一致しない場合はエラー' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'bbbbbb'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end
end
