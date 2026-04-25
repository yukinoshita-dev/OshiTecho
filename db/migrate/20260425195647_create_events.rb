class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true
      t.references :oshi, null: false, foreign_key: true
      t.string :title, null: false
      t.integer :event_type, default: 0, null: false
      t.string :venue
      t.date :event_date, null: false
      t.time :open_time
      t.time :start_time
      t.time :end_time
      t.integer :ticket_price
      t.integer :payment_status, default: 0, null: false
      t.string :seat
      t.boolean :expedition, default: false, null: false
      t.integer :transport, default: 0, null: false
      t.text :note
      t.integer :visibility, default: 0, null: false

      t.timestamps
    end
  end
end
