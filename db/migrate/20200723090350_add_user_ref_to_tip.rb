class AddUserRefToTip < ActiveRecord::Migration[5.2]
  def change
    add_reference :tips, :user, foreign_key: true
  end
end
