require 'rails_helper'

RSpec.describe "Profile", type: :system do
  describe 'プロフィール' do
    let(:user) { create(:user) }
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user)
      visit root_path
      click_on 'LINEアカウントでログイン'
      visit profile_path
    end
    context 'プロフィール詳細' do
      it 'プロフィール名が表示されている' do
        expect(page).to have_content(user.profile.name)
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
    context 'プロフィール編集' do
      before do
        visit edit_profile_path
      end
      it 'フォームが正しく表示されている' do
        expect(page).to have_field('名前', with: user.profile.name)
        expect(page).to have_field('自己紹介')
        expect(page).to have_selector("img[src$='test.png']")
      end
      it 'フォームの内容を変更して更新することができる' do
        fill_in '名前', with: 'test_user_2'
        fill_in '自己紹介', with: '自己紹介テスト'
        attach_file 'profile[avatar]', Rails.root.join('spec/fixtures/test2.png')

        click_on '更新'
        expect(page).to have_current_path(profile_path)
        expect(page).to have_content 'test_user_2'
        expect(page).to have_content '自己紹介テスト'
        expect(page).to have_selector("img[src$='test2.png']")
      end
    end
  end
end
