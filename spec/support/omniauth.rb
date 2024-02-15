# テスト用のモックを使うための設定
# /auth/providerへのリクエストが即座にauth/provider/callbackにリダイレクトされる
OmniAuth.config.test_mode = true

# Line用のモック
# auth/provider/callbackにリダイレクトされた時に渡されるデータを生成
OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
  provider: 'line',
  uid: '12345',
  info: { email: 'test1@example.com', name: 'test_user' },
  credentials: { token: '1234qwer' }
)
