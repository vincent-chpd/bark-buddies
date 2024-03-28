class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :content, :conversation_id, :user_id

  def message_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def sender?(a_user)
    user_id == a_user.id
  end
end
