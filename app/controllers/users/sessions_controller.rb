class Users::SessionsController < Devise::SessionsController
  def destroy
    super
    flash.delete(:notice)
    flash[:alert] = 'ログアウトしました'
  end
end
