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
          // ブロードキャストされたメッセージを表示
          this.messagesTarget.innerHTML += data.message
          this.scrollToBottom();
          console.log("hello")
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
