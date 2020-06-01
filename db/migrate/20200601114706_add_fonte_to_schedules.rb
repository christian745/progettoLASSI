class AddFonteToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :fonte, :string
  end
end
