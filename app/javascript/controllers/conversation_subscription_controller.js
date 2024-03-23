import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="conversation-subscription"
export default class extends Controller {
  static values = { conversationId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConversationChannel", id: this.conversationIdValue },
      { received: (data) => { this.insertMessageAndScrollDown(data) }}
    )
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.markMessagesAsRead()
  }

  resetForm(event) {
    event.preventDefault()
    event.target.reset()
}

  insertMessageAndScrollDown(data){
      this.messagesTarget.insertAdjacentHTML("beforeend", data)
      this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  markMessagesAsRead() {
    fetch(`/conversations/${this.conversationIdValue}/update_read_status`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ read: true })
    }).then(response => {
      if (response.ok) {
        console.log('Messages updated successfully');
      } else {
        console.error('Error updating messages');
      }
    }).catch(error => {
      console.error('Network error:', error);
    });
  }
}
