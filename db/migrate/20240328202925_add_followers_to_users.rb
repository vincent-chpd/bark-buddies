class AddFollowersToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :followers, :integer, default: 0
  end
end
