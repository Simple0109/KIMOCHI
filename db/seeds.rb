require 'securerandom'

User.destroy_all
Profile.destroy_all

10.times do |i|
  user = User.create!(
    email: "test#{ i + 1 }@example.com",
    password: "password",
    password_confirmation: "password",
    uid: SecureRandom.uuid,
    provider: :line
  )

  Profile.create!(
    name: "ユーザー#{ i + 1 }",
    description: "これはユーザー#{i+1}のプロフィールです。",
    user_id: user.id
  )
end

puts "管理者ユーザーとプロフィールを作成しました"
puts "合計#{User.count}人のユーザーと#{Profile.count}件のプロフィールを作成しました"
