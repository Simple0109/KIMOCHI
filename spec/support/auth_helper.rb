module AuthHelpers
  def user_sign_in_via_line
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
      provider: 'line',
      uid: '12345',
      info: { email: 'test1@example.com', name: 'test_user' },
      credentials: { token: '1234qwer' }
    )
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:line]
  end
end
