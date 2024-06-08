require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデルのテスト' do
    let(:valid_user) { create(:user) }

    it '有効なuserの場合保存されるか' do
      expect(valid_user).to be_valid
    end

    context 'バリデーションチェック' do
      it 'uidが空白の場合、エラーが起きるか' do
        user = build(:user, uid: " ")
        expect(user).not_to be_valid
      end

      it 'uidがnilの場合、エラーが起きるか' do
        user = build(:user, uid: nil)
        expect(user).not_to be_valid
      end

      it 'uidが重複している場合、エラーが起きるか' do
        valid_user
        user = build(:user, uid: valid_user.uid)
        expect(user).not_to be_valid
      end

      it 'providerが空白の場合、エラーが起きるか' do
        user = build(:user, provider: " ")
        expect(user).not_to be_valid
      end

      it 'providerがnilの場合、エラーが起きるか' do
        user = build(:user, provider: nil)
        expect(user).not_to be_valid
      end

      it 'passwordが空白の場合、エラーが起きるか' do
        user = build(:user, password: " ")
        expect(user).not_to be_valid
      end

      it 'passwordがnilの場合、エラーが起きるか' do
        user = build(:user, password: nil)
        expect(user).not_to be_valid
      end

      it 'emailが空白の場合、エラーが起きるか' do
        user = build(:user, email: " ")
        expect(user).not_to be_valid
      end

      it 'emailがnilの場合、エラーが起きるか' do
        user = build(:user, email: nil)
        expect(user).not_to be_valid
      end
    end
  end
end
