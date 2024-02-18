module AuthHelpers
  def user_sign_in_via_line(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
      provider: 'line',
      uid: user.uid ,
      info: {
        email: user.email,
         name: user.profile.name,
         avatar: user.profile.avatar
      },
      credentials: { token: '1234qwer' }
    )

  end
end
