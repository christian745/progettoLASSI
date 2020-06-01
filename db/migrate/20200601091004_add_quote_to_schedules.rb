class AddQuoteToSchedules < ActiveRecord::Migration[5.2]
  def change
    add_column :schedules, :quote, :string
  end
end
