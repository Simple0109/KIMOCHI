import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  static targets = [ "messages", "newMessage" ]
  static values = { requestId: Number, currentUserId: Number }

  connect() {
    this.channel = consumer.subscriptions.create(
      { channel: "ChatChannel", request_id: this.requestIdValue },
      {
        received: data => {
          // 送信者が現在のユーザーかどうかを判断
          const isCurrentUser = data.user_id === this.currentUserIdValue;
          const messageClass = isCurrentUser ? 'chat chat-start' : 'chat chat-end';
        
          // ブロードキャストされたメッセージを表示
          this.messagesTarget.innerHTML += `
            <div class="${messageClass}">
              <div class="chat-header">
                ${data.user_name}
                <time class="text-xs opacity-50">${data.created_at}</time>
              </div>
              <div class="chat-bubble">${data.content}</div>
            </div>
          `;
        
          this.scrollToBottom();

        }
      }
    );
    this.scrollToBottom();
  }

  scrollToBottom() {
    this.messagesTarget.scrollTop = this.messagesTarget.scrollHeight;
  }

  send(event) {
    event.preventDefault()
    this.channel.perform('speak', {
      message: this.newMessageTarget.value,
      request_id: this.requestIdValue,
      user_id: this.currentUserIdValue }),
    this.newMessageTarget.value = ''
  }
}
