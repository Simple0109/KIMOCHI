class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action
  end

  private

  def basic_action
    # @omniauthに認証情報(request.env["omniauth.auth"])を格納
    @omniauth = request.env['omniauth.auth']
    if @omniauth.present?
      # @omniauthが存在する場合、Userからproviderとuidが一致するものを特定、ない場合は生成
      @user = User.find_or_initialize_by(provider: @omniauth['provider'], uid: @omniauth['uid'])
      # @userが新しいレコードの場合、下の処理を実行
      if @user.new_record?
        # emailは@omniauthの["info"]["email"]の値、もしくはfake_emailで生成した値
        email = @omniauth['info']['email'] || fake_email(@omniauth['uid'], @omniauth['provider'])
        # assign_attributeでemail, passwordを変更（保存はしない）
        @user.assign_attributes(email:, password: Devise.friendly_token[0, 20])
        @user.save!
      end

      @user.set_values(@omniauth)
      @user.set_profile_name(@omniauth['info']['name']) if @omniauth['info']['name'].present?
      @user.set_profile_avatar(@omniauth['info']['image']) if @omniauth['info']['image'].present?
      flash[:notice] = "ログインしました"
      sign_in_and_redirect @user
    else
      flash[:alert] = '認証に失敗しました'
      new_user_session_path
    end
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
