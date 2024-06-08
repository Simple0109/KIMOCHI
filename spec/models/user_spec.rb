require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Userモデルのバリデーションのテスト' do
    let(:valid_user) { create(:user) }

    it '有効なuserの場合保存されるか' do
      valid_user
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

  describe 'Userモデルのアソシエーションのテスト' do
    it { should have_many(:group_users).dependent(:destroy) }
    it { should have_many(:groups).through(:group_users) }
    it { should have_many(:request_users).dependent(:destroy) }
    it { should have_many(:requests).through(:request_users) }
    it { should have_one(:profile).dependent(:destroy) }
    it { should accept_nested_attributes_for(:profile) }
    it { should have_many(:messages).dependent(:destroy) }
    it { should have_many(:owned_groups).class_name('Group').inverse_of(:owner).dependent(:destroy) }
  end
end
