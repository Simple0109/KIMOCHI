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
      @user.set_profile_avatar(@omniauth.info.image) if @omniauth.info.image.present?
      sign_in(:user, @user)
    end
    flash[:notice] = 'ログインしました'
    redirect_to root_path
  end

  def fake_email(uid, provider)
    "#{uid}-#{provider}@example.com"
  end
end
