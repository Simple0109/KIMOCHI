class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for Request.find(params[:request_id])
  end

  def speak(data)
    request = Request.find(data['request_id'])
    user = User.find(data['user_id'])

    message = request.messages.create(content: data['message'], user: user)

    # 保存されたメッセージをブロードキャスト
    ChatChannel.broadcast_to(request, {
      user_id: user.id,
      user_name: user.profile.name,
      created_at: message.formatted_created_at,
      content: message.content
    })
  end
end
