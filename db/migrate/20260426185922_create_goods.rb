class CreateGoods < ActiveRecord::Migration[8.1]
  def change
    create_table :goods do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :oshi,  null: true,  foreign_key: true
      t.string     :name,          null: false
      t.string     :category
      t.date       :purchase_date
      t.integer    :price,         default: 0
      t.text       :note

      t.timestamps
    end
    add_index :goods, [:user_id, :purchase_date]
  end
end
