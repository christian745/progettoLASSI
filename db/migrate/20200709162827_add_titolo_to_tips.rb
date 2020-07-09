class AddTitoloToTips < ActiveRecord::Migration[5.2]
  def change
    add_column :tips, :titolo, :string
  end
end
