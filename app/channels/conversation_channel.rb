class ConversationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    @conversation = Conversation.find(params[:id])
    stream_for @conversation
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  end

  def mark_as_read
    @conversation.messages.update_all(read: true)
  end
end
