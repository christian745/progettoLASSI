class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.string :user
      t.string :categoria
      t.text :contenuto

      t.timestamps
    end
  end
end
