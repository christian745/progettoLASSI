class AddTitoloToSchedule < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :titolo, :string
  end
end
