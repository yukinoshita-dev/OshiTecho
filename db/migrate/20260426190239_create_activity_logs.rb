class CreateActivityLogs < ActiveRecord::Migration[8.1]
  def change
    create_table :activity_logs do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :oshi,  null: true,  foreign_key: true
      t.references :event, null: true,  foreign_key: true
      t.string     :title,                null: false
      t.text       :body
      t.integer    :rating,               default: 0
      t.integer    :visibility,           default: 0, null: false
      t.integer    :transport_cost,       default: 0
      t.integer    :accommodation_cost,   default: 0
      t.integer    :food_cost,            default: 0
      t.string     :companion_note
      t.text       :setlist

      t.timestamps
    end
    add_index :activity_logs, [:user_id, :created_at]
  end
end
