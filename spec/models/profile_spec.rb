require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Profileモデルのテスト' do
    let(:valid_user) { create(:user) }
    let(:profile) { valid_user.profile }

    it '有効なプロフィールの場合、保存されるか' do
      expect(valid_user.profile).to be_valid
    end

    context 'Profileモデルのバリデーションのテスト' do
      it 'nameが空白の場合、エラーを返すか' do
        profile = build(:profile, name: " ")
        expect(profile).not_to be_valid
      end

      it 'nameがnilの場合、エラーを返すか' do
        profile = build(:profile, name: nil)
        expect(profile).not_to be_valid
      end

      it 'roleが空白の場合、エラーを返すか' do
        profile = build(:profile, role: " ")
        expect(profile).not_to be_valid
      end

      it 'roleがnilの場合、エラーを返すか' do
        profile = build(:profile, role: nil)
        expect(profile).not_to be_valid
      end

      it 'avatarのコンテンツタイプが正しくない場合、エラーを返すか' do
        profile = build(:profile)
        profile.avatar.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'test.txt')),
          filename: 'test.txt',
          content_type: 'text/plain'
        )
        expect(profile).not_to be_valid
      end

      it 'avatarの画像ファイルサイズが重たすぎる場合、エラーを返すか' do
        profile = build(:profile)
        profile.avatar.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', '10MB.jpeg')),
          filename: '10MB.jpeg',
          content_type: 'image/jpeg'
        )
        expect(profile).not_to be_valid
      end
    end

    context 'アソシエーションのテスト' do
      it { should belong_to(:user) }
      it { should have_one_attached(:avatar) }
    end

    context 'クラスメソッドのテスト' do
      it 'avatar_thumbnailが正しく動作するか' do
        expect(profile.avatar_thumbnail).to be_a(ActiveStorage::VariantWithRecord)
      end
    end
  end
end
