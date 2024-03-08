class AddReferenceToDog < ActiveRecord::Migration[7.1]
  def change
    add_reference :dogs, :user, null: false, foreign_key: true
  end
end
