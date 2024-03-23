import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="conversation-subscription"
export default class extends Controller {
  static values = { conversationId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "ConversationChannel", id: this.conversationIdValue },
      { received: (data) => {
        this.insertMessageAndScrollDown(data)
      }}
    )

    // this.readStatusChannel = createConsumer().subscriptions.create(
    //   { channel: "ReadStatusChannel"},
    //   { received: data => console.log(data)}
    // )
    this.markMessagesAsRead()
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  disconnect() {
    this.channel.unsubscribe()
    // this.readStatusChannel.unsubscribe()
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
