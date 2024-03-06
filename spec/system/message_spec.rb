require 'rails_helper'

RSpec.describe 'Message', type: :system do
  describe 'チャット関係' do
    let!(:user_0) { create(:user) }
    let!(:user_1) { create(:user) }
    let!(:group) { create(:group, owner: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_1) }
    let!(:request) { create(:request, user: user_0, group:) }
    let!(:request_user) { create(:request_user, request:, user: user_1) }

    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user_0)
      visit root_path
      click_on 'LINEアカウントでログイン'
      visit group_request_path(group, request)

      using_session('user_1') do
        Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
        user_sign_in_via_line(user_1)
        visit root_path
        click_on 'LINEアカウントでログイン'
      end
    end

    after do
      Capybara.reset_sessions! # セッションを状態をリセット
    end

    context 'チャット送信' do
      it '既存チャットメッセージの表示が成功している' do
        fill_in 'chat_text', with: 'テストチャット'
        find_button('send_button').click
        expect(page).to have_content('テストチャット')

        using_session('user_1') do
          visit group_request_path(group, request)
          expect(page).to have_content('テストチャット')
        end
      end

      it 'チャットを送信したとき、その内容が自分と相手のチャット欄にリアルタイムで反映される', js: true do
        using_session('user_1') do
          visit group_request_path(group, request)
          fill_in 'chat_text', with: 'テストチャット2'
          find_button('send_button').click
          expect(page).to have_content('テストチャット2')
        end

        expect(page).to have_content('テストチャット2')
      end
    end
  end
end
