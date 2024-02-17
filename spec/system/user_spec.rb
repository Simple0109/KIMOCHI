require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user) { create(:user) }

  before do
    user_sign_in_via_line
    visit root_path
  end

  describe 'ログイン' do
    context 'LINEログインボタンを押した場合' do
      it 'ログインができる' do
        click_on 'LINEアカウントでログイン'
        expect(page).to have_content 'マイページ'
      end
    end
  end

  describe 'ログアウト', type: :system do
    context 'ログアウトボタンを押した場合' do
      it 'ログアウトが成功する' do
        click_on 'LINEアカウントでログイン' # このクリックはログアウトテストの場合不要に見える
        click_on 'ログアウト'
        accept_alert 'ログアウトしますか？'
        expect(page).to have_content 'LINEでログイン'
      end
    end
  end
end
