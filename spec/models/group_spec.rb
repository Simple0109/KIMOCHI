require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'Groupモデルのテスト' do
    let(:valid_group) { create(:group) }
    it '有効なgroupの場合、保存されるか' do
      valid_group
      expect(valid_group).to be_valid
    end

    context 'Groupモデルのバリデーションのテスト' do
      it 'nameが空白の場合、エラーが起きるか' do
        group = build(:group, name: " ")
        expect(group).not_to be_valid
      end

      it 'nameが空白の場合、エラーが起きるか' do
        group = build(:group, name: nil)
        expect(group).not_to be_valid
      end
    end
  end

  describe 'クラスメソッドのテスト' do
    context 'owner?メソッド' do
      it 'ユーザーがグループのオーナーの場合、trueを返す' do
        user = create(:user)
        group = create(:group, owner: user)
        expect(group.owner?(user)).to be true
      end

      it 'ユーザーがグループのオーナーでない場合、falseを返す' do
        other_user = create(:user)
        owner = create(:user)
        group = create(:group, owner: owner)
        expect(group.owner?(other_user)).to be false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    it { should have_many(:group_users).dependent(:destroy) }
    it { should have_many(:users).through(:group_users) }
    it { should have_many(:requests).dependent(:destroy) }
    it { should belong_to(:owner).class_name('User').with_foreign_key('user_id').inverse_of(:owned_groups) }
  end
end
