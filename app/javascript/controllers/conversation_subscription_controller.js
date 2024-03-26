import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="conversation-subscription"
export default class extends Controller {
  static values = { conversationId: Number, currentUserId: Number }
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
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)

    // Creating the whole message from the `data.message` String
    const messageElement = this.buildMessageElement(currentUserIsSender, data.message)

    // Inserting the `message` in the DOM
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  buildMessageElement(currentUserIsSender, message) {
    return `
    <div class="message-block" style="${this.justifyClass(currentUserIsSender)}">
    <div class="message-container">
      <div class="message ${this.userStyleClass(currentUserIsSender)}">
        ${message}
      </div>
    </div>
    </div>
    `
  }

  // <div class="message-block" style=<%= custom_style[0] %>>
  //   <div class="message-container">
  //     <% message_time = Time.strptime(message.message_time, "%m/%d/%y at %I:%M %p") %>
  //     <% formatted_message_time = message_time.strftime("%H:%M") %>
  //     <div class="message <%= custom_style[1] %>">
  //       <%= render "messages/message_content", message: message %>
  //       <small ><%= formatted_message_time %></small>
  //     </div>
  //   </div>
  // </div>

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content:flex-end;" : "justify-content:flex-start;"
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "user-message" : "other-user-message"
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
