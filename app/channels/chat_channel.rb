class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_for Request.find(params[:request_id])
  end

  def speak(data)
    request = Request.find(data['request_id'])
    user = User.find(data['user_id'])

    message = request.messages.create(content: data['message'], user: user)

    # 保存されたメッセージをブロードキャスト
    ChatChannel.broadcast_to(request, message: render_message(message))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user})
  end
end
