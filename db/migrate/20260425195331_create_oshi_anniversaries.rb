class CreateOshiAnniversaries < ActiveRecord::Migration[8.1]
  def change
    create_table :oshi_anniversaries do |t|
      t.references :oshi, null: false, foreign_key: true
      t.string :name, null: false
      t.date :date, null: false
      t.boolean :yearly, default: false, null: false

      t.timestamps
    end
  end
end
