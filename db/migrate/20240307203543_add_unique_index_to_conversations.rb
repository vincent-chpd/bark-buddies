class AddUniqueIndexToConversations < ActiveRecord::Migration[7.1]
  def change
    add_index :conversations, [:sender_id, :recipient_id], unique: true
  end
end
