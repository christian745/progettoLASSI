class RemoveUserFromTips < ActiveRecord::Migration[5.2]
  def change
    remove_column :tips, :user
  end
end
