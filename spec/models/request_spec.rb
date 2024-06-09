require 'rails_helper'

RSpec.describe Request, type: :model do
  describe 'Requestモデルのテスト' do
    let(:valid_request) { create(:request) }

    it '有効なrequestの場合、保存されるか' do
      expect(valid_request).to be_valid
    end

    context 'Requestモデルのバリデーションのテスト' do
      it 'takeが空白の場合、エラーを起こすか' do
        request = build(:request, take: " ")
        expect(request).not_to be_valid
      end

      it 'takeがnilの場合、エラーを起こすか' do
        request = build(:request, take: nil)
        expect(request).not_to be_valid
      end

      it '画像のコンテンツタイプ正しくない場合、エラーを起こすか' do
        request = build(:request)
        request.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', 'test.txt')),
          filename: 'test.txt',
          content_type: 'text/plain'
        )
        expect(request).not_to be_valid
      end

      it 'imageの画像ファイルサイズが重たすぎる場合、エラーを返すか' do
        request = build(:request)
        request.image.attach(
          io: File.open(Rails.root.join('spec', 'fixtures', '10MB.jpeg')),
          filename: '10MB.jpeg',
          content_type: 'image/jpeg'
        )
        expect(request).not_to be_valid
      end
    end

    context 'アソシエーションのテスト' do
      it { should belong_to(:user) }
      it { should belong_to(:group) }
      it { should have_many(:request_users).dependent(:destroy) }
      it { should have_many(:authorizers).through(:request_users).source(:user) }
      it { should have_many(:gives).class_name('Give').dependent(:destroy) }
      it { should have_many(:messages).dependent(:destroy) }
    end

    context 'accept_nested_attributes_forのテスト' do
      it 'requestにネストされたgivesが2つもしくは3つの場合正常' do
        request = build(:request)
        expect {
          request.attributes = {
            gives_attributes: [
              { content: "Give 1" },
              { content: "Give 2"}
            ]
          }
        }.not_to raise_error

        expect {
          request.attributes = {
            gives_attributes: [
              { content: "Give 1" },
              { content: "Give 2" },
              { content: "Give 3" }
            ]
          }
        }.not_to raise_error
      end

      it 'requestにネストされたgivesが3つ以上ある場合エラーを起こす' do
        request = build(:request)
        expect {
          request.attributes = {
            gives_attributes: [
              { content: "Give 1" },
              { content: "Give 2" },
              { content: "Give 3" },
              { content: "Give 4" }
            ]
          }
        }.to raise_error(ActiveRecord::NestedAttributes::TooManyRecords)
      end
    end

    context 'enumの値のテスト' do
      it 'statusの値が正しいこと' do
        should define_enum_for(:status).with_values(unauthorized: 0, authorized: 1, possible: 2, completed: 3)
      end

      it 'statusの値が空白の場合、エラーを起こすか' do
        request = build(:request, status: " ")
        expect(request).not_to be_valid
      end

      it 'statusの値がnilの場合、エラーを起こすか' do
        request = build(:request, status: nil)
        expect(request).not_to be_valid
      end
    end
  end
end
