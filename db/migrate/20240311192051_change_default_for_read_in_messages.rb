class ChangeDefaultForReadInMessages < ActiveRecord::Migration[7.1]
  def change
    change_column_default :messages, :read, false
  end
end
