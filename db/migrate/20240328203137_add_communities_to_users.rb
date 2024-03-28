class AddCommunitiesToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :communities, :integer, default: 0
  end
end
