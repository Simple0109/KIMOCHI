require 'rails_helper'

RSpec.describe "Approval", type: :system do
  describe "リクエスト承認関係" do
    let!(:user_0) { create(:user) }
    let!(:user_1) { create(:user) }
    let!(:group) { create(:group, owner: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_1) }
    let!(:request) { create(:request, user: user_0, group:) }
    let!(:request_user) { create(:request_user, request:, user: user_1) }

    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user_1)
      visit root_path
      click_on 'LINEアカウントでログイン'
    end

    context 'リクエスト承認' do
      it '承認ボタンを押した時、承認が成功する' do
        visit group_request_path(group, request)
        find_button('承認').click
        visit group_request_path(group, request)
        expect(page).to have_content('承認済')
      end
    end

    context 'リクエスト承認取消' do
      it '承認取消ボタンを押した時、承認取消が成功する' do
        visit group_request_path(group, request)
        find_button('承認').click
        visit group_request_path(group, request)
        find_button('承認取消').click
        expect(page).to have_content('未承認')
      end
    end
  end

  describe 'give承認関係' do
    let!(:user_0) { create(:user) }
    let!(:user_1) { create(:user) }
    let!(:group) { create(:group, owner: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_1) }
    let!(:request) { create(:request, user: user_0, group:, status: 1) }
    let!(:request_user) { create(:request_user, request:, user: user_1) }

    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user_0)
      visit root_path
      click_on 'LINEアカウントでログイン'
    end

    context 'give完了処理' do
      it '完了ボタンを押した時、成功する' do
        visit group_request_path(group, request)
        find_button('完了').click
        expect(page).to have_content('取消')
      end
    end

    context 'give完了取消処理' do
      it '取消ボタンを押した時、成功する' do
        visit group_request_path(group, request)
        find_button('完了').click
        find_button('取消').click
        expect(page).to have_content('完了')
      end
    end
  end

  describe 'request.status関係' do
    let!(:user_0) { create(:user) }
    let!(:user_1) { create(:user) }
    let!(:group) { create(:group, owner: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_0) }
    let!(:group_user) { create(:group_user, group:, user: user_1) }
    let!(:request) { create(:request, user: user_0, group:, status: 1) }
    let!(:request_user) { create(:request_user, request:, user: user_1) }

    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user_0)
      visit root_path
      click_on 'LINEアカウントでログイン'
    end

    context 'giveの完了状況によって、request.statusが変わる' do
      it '全てのgiveが完了すると、request.statusが2(possible)になる' do
        visit group_request_path(group, request)
        find_button('完了').click
        expect(page).to have_content('タスク実行可能')
      end

      it 'request.statusが2(possible)の状態から、giveの完了を取り消すと、request.statusが1(authorized)になる' do
        visit group_request_path(group, request)
        find_button('完了').click
        expect(page).to have_content('タスク実行可能')
        find_button('取消').click
        expect(page).to have_content('承認済')
      end

      it 'request.statusが2(possible)の状態から、リクエストの完了ボタンを押すとrequest.statusが3(completed)になる' do
        visit group_request_path(group, request)
        find_button('完了').click
        expect(page).to have_content('タスク実行可能')
        find_button('完了').click
        expect(page).not_to have_content(request.take)
        visit completed_group_requests_path(group, request)
        expect(page).to have_content(request.take)
      end
    end
  end
end
