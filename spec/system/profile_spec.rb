require 'rails_helper'

RSpec.describe "Profile", type: :system do
  describe 'プロフィール' do
    before do
      user_sign_in_via_line
      visit root_path
      click_on 'LINEアカウントでログイン'
      visit profile_path
    end
    context 'プロフィール詳細画面が表示されている場合' do
      it 'プロフィール名が表示されている' do
        expect(page).to have_content 'test_user'
      end
      it '編集ボタンを押すとプロフィール編集画面に遷移する' do
        click_on '編集'
        expect(page).to have_current_path(edit_profile_path)
      end
      it '個人リクエスト一覧ボタンを押すと個人リクエスト一覧画面に遷移する' do
        click_on '個人リクエスト一覧'
        expect(page).to have_current_path(personal_requests_profile_path)
      end
    end
  end
end
