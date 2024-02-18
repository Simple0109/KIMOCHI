require 'rails_helper'

RSpec.describe "Group", type: :system do
  describe 'グループ' do
    let!(:user) { create(:user) }
    before do
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
      user_sign_in_via_line(user)
      visit root_path
      click_on 'LINEアカウントでログイン'
    end
    context 'グループ新規作成' do
      it '新規作成に成功する' do
        visit new_group_path
        fill_in "グループネーム", with: "テストグループ"
        click_on '作成'
        expect(page).to have_current_path(groups_path)
        expect(page).to have_content('テストグループ')
      end
    end
    context 'グループ編集' do
      let!(:group) { create(:group, owner: user) }
      it 'グループ詳細画面遷移に成功する' do
        visit group_path(group)
        expect(page).to have_current_path(group_path(group))
      end
      it 'グループ情報の編集に成功する' do
        visit edit_group_path(group)
        fill_in 'グループネーム', with: 'テストグループ更新'
        fill_in '説明', with: '説明テスト'
        click_on '更新'
        expect(page).to have_content('テストグループ更新')
      end
      fit 'グループの削除に成功する' do
        visit group_path(group)
        find_button('削除').click
        expect(page).not_to have_content(group.name)
        expect(page).to have_current_path(groups_path)
      end
    end
  end
end
