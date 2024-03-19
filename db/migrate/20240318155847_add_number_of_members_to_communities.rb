class AddNumberOfMembersToCommunities < ActiveRecord::Migration[7.1]
  def change
    add_column :communities, :number_of_members, :integer
  end
end
