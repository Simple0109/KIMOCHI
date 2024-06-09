require 'rails_helper'

RSpec.describe GroupUser, type: :model do
  describe 'group_userモデルのテスト' do
    let(:valid_group_user) { create(:group_user) }
    let(:user) { create(:user) }
    let(:group) { create(:group) }

    it '有効なgroup_userの場合、保存されるか' do
      expect(valid_group_user).to be_valid
    end

    context 'group_userモデルのバリデーションテスト' do
      it 'user_idが空白の場合、エラーを起こすか' do
        group_user = build(:group_user, user_id: " ")
        expect(group_user).not_to be_valid
      end

      it 'user_idがnilの場合、エラーを起こすか' do
        group_user = build(:group_user, user_id: nil)
        expect(group_user).not_to be_valid
      end

      it 'group_idが空白の場合、エラーを起こすか' do
        group_user = build(:group_user, group_id: " ")
        expect(group_user).not_to be_valid
      end

      it 'group_idが空白の場合、エラーを起こすか' do
        group_user = build(:group_user, group_id: nil)
        expect(group_user).not_to be_valid
      end

      it 'user_idが重複している場合、エラーを起こすか' do
        other_group_user = create(:group_user, user: user, group: group)
        group_user = build(:group_user, user: user, group: group)
        expect(group_user).not_to be_valid
      end
    end

    context 'アソシエーションのテスト' do
      it { should belong_to(:user) }
      it { should belong_to(:group) }
    end
  end
end
