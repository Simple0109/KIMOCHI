require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ログイン' do
    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
    end
    context 'LINEログインボタンを押した場合' do
      it 'ログインができる' do
        visit root_path
        click_on 'LINEアカウントでログイン'
        expect(page).to have_content 'マイページ'
      end
    end
  end
end
