require 'rails_helper'

RSpec.describe "Request", type: :system do
  describe 'リクエスト' do
    let!(:user_0) { create(:user) }
    let!(:user_1) { create(:user) }
    let!(:group) { create(:group, owner: user_0)}
    let!(:group_user) { create(:group_user, group: group, user: user_1)}
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user_0)
      visit root_path
      click_on 'LINEアカウントでログイン'
    end
    context 'リクエスト新規作成' do
      it '新規作成に成功する' do
        visit group_requests_path(group)
        click_on '新規リクエスト作成'
        fill_in 'request_take', with: 'テストリクエスト'
        script = "document.getElementById('request_execution_date').value = '2024-02-22T00:00:00'"
        page.execute_script(script)
        fill_in 'request_gives_attributes_0_content', with: 'テストギブ0'
        fill_in 'request_gives_attributes_1_content', with: 'テストギブ1'
        fill_in 'request_gives_attributes_2_content', with: 'テストギブ2'
        fill_in 'request_comment', with: 'テストコメント'
        check user_1.profile.name
        click_on '登録する'
        expect(page).to have_content 'テストリクエスト'
        expect(page).to have_content "#{user_0.profile.name}"
      end
    end
    context 'リクエスト編集' do
      let!(:user_2) { create(:user) }
      let!(:group_user) { create(:group_user, group: group, user: user_2) }
      let!(:request) { create(:request, user: user_0, group: group) }
      before do
        create(:request_user, request: request, user: user_1)
        create(:request_user, request: request, user: user_2)
      end
      it '編集に成功する' do
        visit edit_group_request_path(group, request)
        fill_in 'request_take', with: 'テストリクエスト更新'
        fill_in 'request_gives_attributes_0_content', with: 'テストギブ更新0'
        fill_in 'request_comment', with: 'テストコメント更新'
        uncheck "request_authorizer_ids_#{user_2.id}"
        click_on '更新する'
        expect(page).to have_current_path(group_request_path(group, request))
        expect(page).to have_content 'テストリクエスト更新'
        expect(page).to have_content 'テストギブ更新'
        expect(page).to have_content 'テストコメント更新'
        expect(page).not_to have_content user_2.profile.name
      end
    end
    context 'リクエスト削除' do
      let!(:request) { create(:request, user: user_0, group: group) }
      before do
        create(:request_user, request: request, user: user_1)
      end
      it '削除に成功する' do
        visit group_request_path(group, request)
        find_button('削除').click
        expect(page).to have_current_path(group_requests_path(group))
        expect(page).not_to have_content(user_0.profile.name)
      end
    end

  end
end
