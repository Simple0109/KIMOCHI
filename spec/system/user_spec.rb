require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン' do
    before do
      user_sign_in_via_line
    end
    context 'LINEログインボタンを押した場合' do
      it 'ログインができる' do
        visit root_path
        click_on 'LINEアカウントでログイン'
        expect(page).to have_content 'マイページ'
      end
    end
  end

  describe 'ログアウト', type: :system do
    context 'ログアウトボタンを押した場合' do
      it 'ログアウトが成功する' do
        user_sign_in_via_line
        visit root_path
        click_on 'LINEアカウントでログイン'
        click_on 'ログアウト'
        accept_alert 'ログアウトしますか？'
        expect(page).to have_content 'LINEでログイン'
      end
    end
  end
end
