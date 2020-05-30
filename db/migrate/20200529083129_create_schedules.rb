class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.string :tipo
      t.string :muscoli
      t.text :descrizione

      t.timestamps
    end
  end
end
